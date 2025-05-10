@echo off
setlocal EnableDelayedExpansion

:: URLs for default .pypack and .pypack-config files
set PYPACK_URL=https://example.com/default.pypack
set CONFIG_URL=https://example.com/default.pypack-config

:: Check for .pypack file
if not exist "*.pypack" (
    echo No .pypack file found. Downloading default from %PYPACK_URL%
    curl -o default.pypack %PYPACK_URL%
    if errorlevel 1 (
        echo Failed to download default .pypack file
        exit /b 1
    )
)

:: Check for .pypack-config file
if not exist "*.pypack-config" (
    echo No .pypack-config file found. Downloading default from %CONFIG_URL%
    curl -o default.pypack-config %CONFIG_URL%
    if errorlevel 1 (
        echo Failed to download default .pypack-config file
        exit /b 1
    )
)

:: Find the first .pypack-config file
for %%C in (*.pypack-config) do (
    set CONFIG_FILE=%%C
    goto :read_config
)
:read_config
if not defined CONFIG_FILE (
    echo No .pypack-config file found after download attempt
    exit /b 1
)

:: Read the executable URL from the .pypack-config file
set /p EXE_URL=<"!CONFIG_FILE!"
if "!EXE_URL!"=="" (
    echo .pypack-config file is empty or invalid
    exit /b 1
)

:: Download the executable
set EXE_NAME=downloaded_exe.exe
echo Downloading executable from !EXE_URL!
curl -o %EXE_NAME% !EXE_URL!
if errorlevel 1 (
    echo Failed to download executable
    exit /b 1
)

:: Find the first .pypack file
for %%F in (*.pypack) do (
    echo Found .pypack file: %%F
    :: Read arguments from the .pypack file
    set /p ARGS=<"%%F"
    :: Run the downloaded executable with the arguments
    %EXE_NAME% !ARGS!
    if errorlevel 1 (
        echo Failed to run executable with arguments from %%F
    )
    goto :done
)

echo No .pypack file found after download attempt
exit /b 1

:done
endlocal