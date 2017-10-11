@echo off
echo Run N64 VC Injector (1)
echo Run Updater (2)
set /p CHOICE=What do you want to do: 
if %CHOICE%==1 goto runinjector
if %CHOICE%==2 goto runupdater
:runinjector
cd Tools
cd N64
start N64INJECTOR.bat
exit
:runupdater
start Updater.bat
exit