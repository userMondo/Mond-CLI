@echo off
setlocal enabledelayedexpansion

set "CONFIG_FILE=%~dp0aliases.cfg"
set "TEMP_FILE=%~dp0temp.cfg"

REM Command validation
if "%~1"=="" goto :usage
if "%~1"=="add" goto :add
if "%~1"=="list" goto :list
if "%~1"=="run" goto :run
if "%~1"=="delete" goto :delete
if "%~1"=="rename" goto :rename
goto :usage

:add
if "%~2"=="" goto :usage
if not exist "%~2" (
    echo Error: File does not exist: "%~2"
    goto :eof
)

REM Prompt for alias name
set /p "ALIAS=Enter the alias name for "%~2": "
if "%ALIAS%"=="" (
    echo Error: Alias name cannot be empty.
    goto :eof
)

REM Check if alias already exists
for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do (
    if "%%A"=="%ALIAS%" (
        echo Error: Alias "%ALIAS%" already exists.
        goto :eof
    )
)

REM Add the alias and path to the configuration file
echo %ALIAS%="%~2">> "%CONFIG_FILE%"
echo Added alias: "%ALIAS%" for "%~2"
goto :eof

:list
if not exist "%CONFIG_FILE%" (
    echo No aliases found.
    goto :eof
)
echo List of aliases:
for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do (
    echo %%A = %%B
)
goto :eof

:run
if "%~2"=="" goto :usage
if not exist "%CONFIG_FILE%" (
    echo No aliases found.
    goto :eof
)
set "FOUND="
for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do (
    if "%%A"=="%~2" (
        set "EXEC_PATH=%%B"
        set "FOUND=1"
        goto :execute
    )
)
if not defined FOUND (
    echo Error: Alias not found: "%~2"
    goto :eof
)

:execute
if not exist "!EXEC_PATH!" (
    echo Error: Executable not found: "!EXEC_PATH!"
    goto :eof
)
start "" "!EXEC_PATH!"
goto :eof

:delete
if "%~2"=="" goto :usage
if not exist "%CONFIG_FILE%" (
    echo No aliases found.
    goto :eof
)

REM Remove the alias from the configuration file
set "FOUND=0"
(
    for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do (
        if "%%A"=="%~2" (
            set "FOUND=1"
        ) else (
            echo %%A=%%B
        )
    )
) > "%TEMP_FILE%"

REM Replace the original configuration file with the updated one
if %FOUND%==0 (
    echo Error: Alias not found: "%~2"
    del "%TEMP_FILE%"
) else (
    move /y "%TEMP_FILE%" "%CONFIG_FILE%"
    echo Deleted alias: "%~2"
)
goto :eof

:rename
if "%~2"=="" goto :usage
if "%~3"=="" goto :usage
if not exist "%CONFIG_FILE%" (
    echo No aliases found.
    goto :eof
)

set "FOUND=0"
set "NEW_ALIAS_EXISTS=0"

REM Check if the original alias exists and the new alias does not already exist
for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do (
    if "%%A"=="%~2" (
        set "FOUND=1"
        set "OLD_EXEC_PATH=%%B"
    )
    if "%%A"=="%~3" (
        set "NEW_ALIAS_EXISTS=1"
    )
)

if %FOUND%==0 (
    echo Error: Alias "%~2" not found.
    goto :eof
)

if %NEW_ALIAS_EXISTS%==1 (
    echo Error: Alias "%~3" already exists.
    goto :eof
)

REM Rename the alias in the configuration file
(
    for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do (
        if "%%A"=="%~2" (
            echo %~3=!OLD_EXEC_PATH!
        ) else (
            echo %%A=%%B
        )
    )
) > "%TEMP_FILE%"

REM Replace the original configuration file with the updated one
move /y "%TEMP_FILE%" "%CONFIG_FILE%"
echo Renamed alias "%~2" to "%~3"
goto :eof

:usage
echo Usage:
echo.
echo mond add ^<path\to\file.exe^>
echo    Adds a new executable path to the configuration file.
echo    You will be prompted to enter an alias name for the executable.
echo.
echo mond list
echo    Lists all aliases and their corresponding executable paths from the configuration file.
echo.
echo mond run ^<alias^>
echo    Launches the executable associated with the given alias.
echo.
echo mond delete ^<alias^>
echo    Removes the alias and its associated executable path from the configuration file.
echo.
echo mond rename ^<old_alias^> ^<new_alias^>
echo    Renames an existing alias to a new name.
echo.
goto :eof
