:: Made by VastraKai#0001 for Latite Client/Injector

@title LatiteInjector Downloader
@if /i not "%batdebug%" == "true" @echo off

set LatiteExeLocation=%userprofile%\Desktop
set LatiteExeName=Injector.exe
set LatiteFullPath=%LatiteExeLocation%\%LatiteExeName%
set InjectorLink=https://github.com/Imrglop/Latite-Releases/raw/main/injector/Injector.exe
set InjectorLinkBetter=https://github.com/Plextora/LatiteInjector/releases/latest/download/LatiteInjector.exe

:checkPrivileges
net file 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=
echo Waiting for elevation...
echo =-=-=-=-=-=-=-=-=-=-=-=-=
:: short file names are required here, if you don't use them you will get errors with spaces
powershell.exe Start-Process cmd.exe -Verb RunAs -ArgumentList "/c","`"%~dps0\%~nxs0`"","`&echo." 
goto :EOF

:gotPrivileges 
:: =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Start of batch file
if not exist "%LatiteExeLocation%" md "%LatiteExeLocation%"
cd /d "%LatiteExeLocation%"
echo Latite will be downloaded to: '%LatiteFullPath%'.
timeout -t 3  > nul


echo Adding exclusions to Windows Defender.
>nul powershell Add-MpPreference -ExclusionPath "%LatiteExeLocation%"
if not "%errorlevel%" == "0" echo Failed to add exclusion. (Windows Defender is probably disabled already.)
>nul powershell Add-MpPreference -ExclusionProcess "%LatiteExeName%"
if not "%errorlevel%" == "0" echo Failed to add exclusion. (Windows Defender is probably disabled already.)
>nul powershell Add-MpPreference -ExclusionProcess "cmd.exe"
if not "%errorlevel%" == "0" echo Failed to add exclusion. (Windows Defender is probably disabled already.)
>nul powershell Add-MpPreference -ExclusionProcess "powershell.exe"
if not "%errorlevel%" == "0" echo Failed to add exclusion. (Windows Defender is probably disabled already.)

echo Downloading Latite Injector...
taskkill /f /im "%LatiteExeName%" > nul 2>&1
start /wait "LatiteInjector Downloader" cmd /c bitsadmin /TRANSFER LatiteDownload /DOWNLOAD %InjectorLink% "%LatiteFullPath%"

if not "%errorlevel%" == "0" (
    echo Download failed!
    pause
    goto :EOF
)
start "" "%LatiteFullPath%"
echo Latite Injector has now on your desktop!
timeout -t 3  > nul
del /f /q "%~0"