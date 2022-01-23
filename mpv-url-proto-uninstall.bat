@ECHO off
REM https://github.com/b01o/mpv-url-proto @b01o
REM A script to remove previous installed mpv protocol support.

ECHO Uninstalling mpv url protocol..
ECHO Checking permissions...
REM CHECKING PERMISSION
NET SESSION >nul 2>&1
IF NOT %errorLevel% == 0 (
    ECHO Administrative permissions required, abort...
    PAUSE
    EXIT /b 1
)

ECHO Cleanup regedit...
REM DELETE PROTOCOL FROM REGEDIT
REG DELETE HKEY_CLASSES_ROOT\mpv /f
ECHO Removing the helper...
IF EXIST "%HOMEPATH%\.scripts\open_in_mpv.bat" (
    DEL "%HOMEPATH%\.scripts\open_in_mpv.bat"
)
ECHO Done... mpv url protocol now is REMOVED.
PAUSE
