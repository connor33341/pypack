@echo off
setlocal

:: URL of the script to download
set SCRIPT_URL=https://raw.githubusercontent.com/connor33341/pypack/refs/heads/main/scripts/wrappers/windows.bat

:: Name of the downloaded file
set SCRIPT_NAME=pypack.bat

:: Download the script using curl
curl -o "%SCRIPT_NAME%" "%SCRIPT_URL%"

call "%SCRIPT_NAME%"

endlocal