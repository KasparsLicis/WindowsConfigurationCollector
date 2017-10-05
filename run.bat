::	Script start...
::	@echo off
::	Change Directory to the script's one, since Stupid windows will execute at "\windows\system32" when chosen to run as administrator...
cd /d "%~d0%~p0"

::Get Date and Time
For /F "tokens=1,2,3,4 delims=/ " %%A in ('Date /t') do @( 
Set FullDate="%%D-%%C-%%B"
)

For /F "tokens=1,2,3 delims=: " %%A in ('time /t') do @( 
Set FullTime="%%A-%%B"
)

set dirname="%computername%_%FullDate%_%FullTime%"
mkdir "%dirname%"
cd "%dirname%"
set var=%computername%.txt

type ..\commands.txt >> %var%

for /f "tokens=*" %%a in (..\commands.txt) do @(
echo. >> %var%
echo. >> %var%
echo ======================================== >> %var%
echo ======================================== >> %var%
echo %%a >> %var%
echo ======================================== >> %var%
echo ======================================== >> %var%
cmd /c "%%a" >> %var%
)
cd ..
cd Sysinternals
autorunsc.exe -a -f -c >> ..\%dirname%\autoruns.csv
handle.exe -a -u >> ..\%dirname%\handles.txt
HiJackThis.EXE /silentautolog
move hijackthis.log ..\%dirname%\
listdlls.exe >> ..\%dirname%\dlls.txt
psinfo -s -h -d >> ..\%dirname%\psinfo.txt
pslist -t >> ..\%dirname%\pslist.txt
psgetsid >> ..\%dirname%\psgetsid.txt
psloggedon.exe >> ..\%dirname%\psloggedon.txt
Tcpvcon.exe -a -c -n >> ..\%dirname%\tcpvcon.txt
