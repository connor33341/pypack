@echo off
setlocal

:: URL of the script to download
set SCRIPT_URL=https://example.com/script-to-download.sh

:: Name of the downloaded file
set SCRIPT_NAME=pypack.bat

:: Download the script using curl
curl -o "%SCRIPT_NAME%" "%SCRIPT_URL%"

call "%SCRIPT_NAME%"

endlocal