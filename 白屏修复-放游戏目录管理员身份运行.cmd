@echo off
setlocal

rem 要信任的目录：脚本所在目录
set "TRUST_DIR=%~dp0"

echo 将以下目录加入 Flash 信任列表：
echo %TRUST_DIR%

rem ================= 系统级 Flash 信任 =================
cd /d "%windir%\system32\Macromed\Flash" 2>nul
if not exist FlashPlayerTrust md FlashPlayerTrust
cd FlashPlayerTrust

rem 只写入当前目录
echo %TRUST_DIR%>> myTrustFiles.cfg

rem ================= 用户级 Flash 信任 =================
cd /d "%userprofile%\AppData\Roaming\Macromedia\Flash Player" 2>nul
if not exist "#Security" md "#Security"
cd "#Security"
if not exist FlashPlayerTrust md FlashPlayerTrust
cd FlashPlayerTrust

rem 同样只写入当前目录
echo %TRUST_DIR%>> myTrustFiles.cfg

echo.
echo 已完成。
pause
