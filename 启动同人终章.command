#!/bin/zsh
set -uo pipefail
project_dir="${0:A:h}"
cd "$project_dir" || exit 1
python_bin="${YZLR2_PYTHON:-/opt/miniconda3/envs/Qubit/bin/python}"
umask 077
log_dir="$project_dir/reverse/logs/chapter-launcher"
mkdir -p "$log_dir" || exit 1
log_file="$log_dir/$(/bin/date -u +%Y%m%dT%H%M%SZ)-$$.log"
print "《归光之约》启动日志：$log_file"
status_code=0
if [[ ! -x "$python_bin" ]]; then
  print '未找到 Qubit Python。可设置 YZLR2_PYTHON 为已配置的 Python 可执行文件。' | /usr/bin/tee "$log_file"
  status_code=1
else
  "$python_bin" "$project_dir/reverse/tools/launch_rebuilt.py" "$@" --expect-save yzlr2_rebuild_epilogue_v2 2>&1 | /usr/bin/tee "$log_file"
  status_code=$pipestatus[1]
fi
if (( status_code != 0 )) && [[ -t 0 && "$*" != *--check* ]]; then
  read '?按回车关闭本窗口…'
fi
exit "$status_code"
