#!/bin/zsh
set -euo pipefail
game_dir="${0:A:h}"
cd "$game_dir"
runtime_dir="$game_dir/.runtime"
player_app="$runtime_dir/adobe/Flash Player.app"
mount_dir=''
save_root="$HOME/Library/Preferences/Macromedia/Flash Player/#SharedObjects"

backup_save() {
  local phase="$1" source destination='' relative
  # 只复制本游戏的存档，保留 Flash 随机目录名以方便恢复。
  for source in "$save_root"/*/localhost/yzlr2_final.sol(N) "$save_root"/*/localhost/yzlr2_epilogue.sol(N); do
    if [[ -z "$destination" ]]; then
      mkdir -p "$game_dir/save-backups"
      destination="$(mktemp -d "$game_dir/save-backups/$(date +%Y%m%d-%H%M%S)-adobe-${phase}-XXXXXX")"
    fi
    relative="${source#"$save_root"/}"
    mkdir -p "${destination}/${relative:h}"
    ditto "$source" "$destination/$relative"
  done
  [[ -z "$destination" ]] || echo "存档已备份：$destination"
  return 0
}
cleanup() {
  if [[ -n "$mount_dir" ]]; then
    hdiutil detach "$mount_dir" -quiet || true
  fi
  backup_save after
}
trap cleanup EXIT

if [[ ! -x "$player_app/Contents/MacOS/Flash Player" ]]; then
  mkdir -p "$runtime_dir/downloads" "$runtime_dir/adobe"
  archive="$runtime_dir/downloads/flashplayer_32_sa.dmg"
  if [[ ! -f "$archive" ]]; then
    echo '从 Adobe 官方服务器下载 Mac 独立播放器…'
    curl -fL --retry 2 'https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flashplayer_32_sa.dmg' -o "$archive"
  fi
  expected='236ecef54a7d6c3eed739c74b7e14946b07b6156cbcedda3bbbf444f1d17023a'
  actual="$(shasum -a 256 "$archive")"
  if [[ "${actual%% *}" != "$expected" ]]; then
    echo '播放器校验失败，已停止。下载文件保留供检查。'
    exit 1
  fi
  mount_dir="$(mktemp -d "$runtime_dir/adobe-mount-XXXXXX")"
  hdiutil attach "$archive" -readonly -nobrowse -mountpoint "$mount_dir" -quiet
  ditto "$mount_dir/Flash Player.app" "$player_app"
  hdiutil detach "$mount_dir" -quiet
  mount_dir=''
  codesign --verify --deep --strict "$player_app"
fi

/opt/miniconda3/envs/Qubit/bin/python "$game_dir/tools/prepare_epilogue.py"
backup_save before
echo '同人终章开发版已启动。先读档，再点击右上角终章按钮；请使用英文输入法。'
echo '退出前点击游戏内“系统 → 保存进度”，看到“游戏保存成功”后用 ⌘Q 退出。'
echo '播放器退出后会自动备份存档；请保留本终端窗口直到游戏结束。'
/usr/bin/open -W -a "$player_app" "$game_dir/终章入口.swf"
