#!/bin/zsh
set -uo pipefail
project_dir="${0:A:h}"
cd "$project_dir" || exit 1
python_bin="${YZLR2_PYTHON:-/opt/miniconda3/envs/Qubit/bin/python}"
status_code=0
if [[ ! -x "$python_bin" ]]; then
  print -u2 '未找到 Qubit Python。可设置 YZLR2_PYTHON 为已配置的 Python 可执行文件。'
  status_code=1
else
  "$python_bin" "$project_dir/reverse/tools/launch_rebuilt.py" "$@" || status_code=$?
fi
if (( status_code != 0 )) && [[ -t 0 && "$*" != *--check* ]]; then
  read '?按回车关闭本窗口…'
fi
exit "$status_code"
