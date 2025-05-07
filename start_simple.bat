@echo off
setlocal enabledelayedexpansion

echo ====================================
echo       XXXBot Windows Startup Script
echo ====================================
echo Starting...Please wait...

REM Set working directory
set "WORKSPACE_DIR=%~dp0"
set "LOGS_DIR=%WORKSPACE_DIR%logs"

echo [%date% %time%] Starting script execution > "%WORKSPACE_DIR%startup_log.txt"

REM Create logs directory if not exists
if not exist "%LOGS_DIR%" (
    echo Creating logs directory: %LOGS_DIR%
    mkdir "%LOGS_DIR%"
    echo [%date% %time%] Created logs directory: %LOGS_DIR% >> "%WORKSPACE_DIR%startup_log.txt"
)

REM Check if Conda is available and activate base environment
echo Checking Conda installation...
where conda >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Error: Conda not found! Please ensure Conda is installed and added to PATH
    echo [%date% %time%] Error: Conda not found >> "%WORKSPACE_DIR%startup_log.txt"
    pause
    exit /b 1
)

echo Activating Conda xxxbot environment...
REM Initialize conda for batch script
call conda activate xxxbot
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to activate Conda xxxbot environment
    echo [%date% %time%] Error: Failed to activate Conda xxxbot environment >> "%WORKSPACE_DIR%startup_log.txt"
    pause
    exit /b 1
)

REM Check if Python is available in Conda environment
echo Checking Python in Conda environment...
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Error: Python not found in Conda xxxbot environment
    echo [%date% %time%] Error: Python not found in Conda xxxbot environment >> "%WORKSPACE_DIR%startup_log.txt"
    pause
    exit /b 1
)

REM Open terminal to run Redis CLI
echo Starting Redis CLI in a new terminal...
start cmd /k "conda activate xxxbot && cd /d "%WORKSPACE_DIR%" && echo Redis CLI starting... && "%WORKSPACE_DIR%849\redis\redis-server.exe""
echo Redis CLI started

REM Wait briefly before starting PAD service
timeout /t 2 /nobreak > nul

REM Open terminal to run PAD service
echo Starting PAD service in a new terminal...
start cmd /k "conda activate xxxbot && cd /d "%WORKSPACE_DIR%" && echo PAD service starting... && "%WORKSPACE_DIR%849\pad\main.exe""
echo PAD service started

REM Wait briefly before starting main application
timeout /t 2 /nobreak > nul

REM Start main application in current terminal
echo Starting XXXBot main application...
cd /d "%WORKSPACE_DIR%"
echo Running: python main.py
python main.py

echo [%date% %time%] Script execution completed >> "%WORKSPACE_DIR%startup_log.txt"
pause