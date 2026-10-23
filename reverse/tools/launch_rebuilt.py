#!/usr/bin/env python3
"""Validate and launch an explicitly isolated, fully source-rebuilt game package.

No player installation, global configuration, fixture import or SOL access.
--check performs all file/signature checks without starting the player.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import plistlib
import platform
import shlex
import subprocess
import sys
from build_inputs import verify
from launch_inputs import verify_batch
from diagnostic_harness import validate_package

ROOT=Path(__file__).resolve().parents[2]
BUILD=ROOT/'reverse/build'
MAIN='3_L4399Main_gamefile.swf'


def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_launch_fingerprint(fingerprint):
    """Keep all file checks; the compiler's environment is not the player's env."""
    issues=verify(fingerprint)
    # verify still checks the recorded digest and every source/toolchain file.
    # No Java/compiler is invoked on this launch path. A locale or Java build
    # option change cannot alter the already-hashed SWF being handed to Adobe.
    blocking=[issue for issue in issues if issue!='build input environment changed']
    expected=fingerprint.get('environment',{})
    differences=[key for key,value in expected.get('environment',{}).items() if os.environ.get(key)!=value]
    if expected.get('python_version')!=sys.version:differences.append('python_version')
    if expected.get('python_implementation')!=platform.python_implementation():differences.append('python_implementation')
    return blocking,sorted(differences)


def select_package(explicit=None):
    if explicit is not None:
        return explicit.expanduser().resolve()
    candidates=[]
    for path in BUILD.glob('runtime-all-rebuilt-*/assembly.json'):
        try:
            data=json.loads(path.read_text())
            if data.get('state')=='complete' and data.get('rebuilt')==164 and data.get('original_fallback')==0 and data.get('partial_allowed') is False:
                candidates.append((data['createdUTC'],path.parent))
        except (OSError,ValueError,KeyError):continue
    if not candidates:raise ValueError('没有完成的 164/164 严格重建包。')
    # Fail on a stale newest package rather than silently selecting an older game.
    return max(candidates,key=lambda item:item[0])[1]


def validate_inputs(directory):
    assert directory.name.startswith('runtime-all-rebuilt-'), '只允许完整严格组装包'
    directory,main,save_name,assembly_hash=validate_package(directory)
    assert assembly_hash and save_name.startswith('yzlr2_rebuild_'), '主程序必须使用独立重建测试存档名'
    manifest=json.loads((directory/'assembly.json').read_text())
    fingerprints=[]
    for row in manifest['modules']:
        relative=row.get('receipt_snapshot')
        receipt_path=(directory/relative).resolve() if relative else directory/'diagnostic-origin'/(row['receipt_sha256']+'.json')
        assert receipt_path.is_relative_to(directory) and receipt_path.is_file(), '缺少包内构建凭据；请重新严格组装'
        assert sha(receipt_path)==row['receipt_sha256'], '构建凭据哈希改变：'+row['module']
        receipt=json.loads(receipt_path.read_text());fingerprint=receipt.get('input_fingerprint')
        assert fingerprint and fingerprint.get('post_build_verified') is True, '旧包缺少真实构建前后输入指纹：'+row['module']
        assert fingerprint.get('module')==row['module'], '输入指纹模块不符'
        assert row.get('input_generation')==fingerprint['generation'] and row.get('input_digest')==fingerprint['digest'], '组装输入指纹与构建凭据不符'
        fingerprints.append(fingerprint)
    issues,batch=verify_batch(fingerprints,lambda message:print(message,flush=True))
    if issues:raise ValueError('输入已过期：'+json.dumps(issues,ensure_ascii=False))
    return {'package':str(directory),'main':str(main),'assembly_sha256':assembly_hash,
        'main_sha256':sha(main),'modules':164,'game_shared_object':save_name,
        **batch,
        'build_environment_policy':'Names only, no values logged. Build-only environment changes (including Java options) do not change verified SWF bytes; no compiler/Java is run here. Rebuild/assemble still require strict environment fingerprints.',
        'source_inputs_current':True,'private_save_accessed':False,'player_started':False}


def debugger_app(explicit=None):
    candidates=[explicit] if explicit else [ROOT/'.runtime/adobe-debug/Flash Player.app',
        (ROOT/'.runtime/shared-tools').resolve().parent/'adobe-debug/Flash Player.app']
    app=next((p.expanduser().resolve() for p in candidates if p and p.is_dir()),None)
    if not app:raise ValueError('未找到现有 Adobe 调试播放器；请用 --player-app 指定已有官方 Flash Player.app。此入口不会下载或安装。')
    info=plistlib.loads((app/'Contents/Info.plist').read_bytes())
    assert info.get('CFBundleIdentifier')=='com.macromedia.Flash Player Debugger.app', '指定应用不是 Adobe Flash 调试播放器'
    assert info.get('CFBundleShortVersionString')=='32.0.0.465', '播放器版本不在已验证范围 32.0.0.465'
    executable=app/'Contents/MacOS'/info['CFBundleExecutable']
    assert executable.is_file(), '播放器可执行文件缺失'
    command=['/usr/bin/codesign','--verify','--deep','--strict',str(app)]
    result=subprocess.run(command,capture_output=True,text=True,timeout=30)
    if result.returncode:raise ValueError('Adobe 应用签名校验失败：'+result.stderr.strip())
    result=subprocess.run(['/usr/bin/codesign','-dv','--verbose=2',str(app)],capture_output=True,text=True,timeout=15)
    assert result.returncode==0 and 'TeamIdentifier=JQ525L2MZD' in result.stderr and 'Authority=Developer ID Application: Adobe Inc.' in result.stderr, '不是预期 Adobe 官方签名'
    return app


def active_players():
    result=subprocess.run(['/bin/ps','-axo','comm='],capture_output=True,text=True,check=True,timeout=15)
    return [line.strip() for line in result.stdout.splitlines() if line.strip().endswith(('/Flash Player','/Flash Player Debugger'))]


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--package',type=Path,help='Select a strict package; default newest complete strict assembly')
    parser.add_argument('--player-app',type=Path,help='Existing official Adobe debugger application')
    parser.add_argument('--check',action='store_true',help='Validate only; never open a player')
    args=parser.parse_args()
    launch_requested=False
    try:
        package=select_package(args.package)
        print('校验严格重建包、全部文件与当前构建输入…',flush=True)
        report=validate_inputs(package);app=debugger_app(args.player_app);running=active_players()
        report.update(player_app=str(app),active_players=running,launch_available=not running)
        if report['build_environment_differences']:
            print('检测到仅构建环境差异（只记录名称）：'+', '.join(report['build_environment_differences'])+'。本次不编译，所有输入文件和产物哈希仍须通过；重新构建时仍严格检查环境。',flush=True)
        if args.check:
            print(json.dumps(report,ensure_ascii=False,indent=2));return
        if running:raise ValueError('已有 Flash 播放器正在运行；请先退出，以免两个实例同时使用测试存档。未关闭任何现有程序。')
        print('重建包：'+report['package']+'\n主文件 SHA-256：'+report['main_sha256'],flush=True)
        print('已验证 164/164 源码重建模块。测试存档：'+report['game_shared_object'],flush=True)
        print('请用英文输入法；保存后退出播放器。此入口直接启动主游戏，不加载诊断 wrapper。',flush=True)
        launch_requested=True
        subprocess.run(['/usr/bin/open','-n','-W','-a',str(app),str(package/MAIN)],check=True)
    except (AssertionError,OSError,ValueError,KeyError,subprocess.SubprocessError) as error:
        print(('播放器打开命令未成功完成：' if launch_requested else '启动未执行：')+str(error),file=sys.stderr)
        command=f'{shlex.quote(sys.executable)} reverse/tools/rebuild_project.py'
        print('在工程根目录执行（缺失或过期时先构建，再组装）：\n'
            f'  cd {shlex.quote(str(ROOT))}\n  {command} build all\n  {command} assemble\n'
            '若刚完成构建，只需 assemble；首次克隆缺少素材或本地工具链时，请先按 reverse/docs/build-project.md 准备依赖。',file=sys.stderr)
        raise SystemExit(1)


if __name__=='__main__':main()
