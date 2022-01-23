@ECHO off
REM https://github.com/b01o/mpv-url-proto @b01o
REM A script to add mpv protocol support for windows.

ECHO Installing mpv url protocol..
ECHO Checking permissions...
REM CHECKING PERMISSION
NET SESSION >nul 2>&1
IF NOT %errorLevel% == 0 (
    ECHO Administrative permissions required, abort...
    PAUSE
    EXIT /b 1
)

ECHO Writing the url protocol onto regedit...
REM ADDIND PROTOCOL INTO REGEDIT
REG ADD HKEY_CLASSES_ROOT\mpv /t REG_SZ /d "URL: mpv" /f
REG ADD HKEY_CLASSES_ROOT\mpv /v "URL Protocol" /t REG_SZ /d "" /f
REG ADD HKEY_CLASSES_ROOT\mpv\shell /f
REG ADD HKEY_CLASSES_ROOT\mpv\shell\open /f
REG ADD HKEY_CLASSES_ROOT\mpv\shell\open\command /t REG_SZ /d "\"%HOMEDRIVE%%HOMEPATH%\.scripts\open_in_mpv.bat\" \"%%1\"" /f

ECHO Installing a helper...
IF NOT EXIST "%HOMEPATH%\.scripts" MKDIR "%HOMEPATH%\.scripts"
(
ECHO @echo off
ECHO title: running mpv
ECHO SET u=%%~1
ECHO start mpv.exe "%%u:~6%%"
)>"%HOMEPATH%\.scripts\open_in_mpv.bat"
ECHO Installed successfully...
PAUSE