@echo off
setlocal enabledelayedexpansion

REM Set the Python installer URL
set "pythonInstallerURL=https://www.python.org/ftp/python/latest/python-3.x.x.exe"

REM Set the destination file name
set "destinationFile=python-installer.exe"

REM Download the Python installer using PowerShell
powershell -command "(New-Object Net.WebClient).DownloadFile('%pythonInstallerURL%', '%destinationFile%')"

REM Check if the download was successful
if not exist %destinationFile% (
    echo Download failed.
    pause
    exit /b 1
)

REM Install Python
echo Installing Python...
start /wait %destinationFile% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

REM Check if Python installation was successful
python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Python installation failed!
    pause
    exit /b 1
)

REM Cleanup: Delete the downloaded installer
del %destinationFile%

REM Installing Requirements
cd /d "%~dp0"
echo Installing Requirements...
python -m pip install -r requirements.txt

exit /b 0

