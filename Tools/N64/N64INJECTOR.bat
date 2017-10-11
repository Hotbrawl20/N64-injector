@echo off
title NicoAICP's N64 VC Injector
echo Please add your z64/n64 or v64 rom to the File directory
pause
cls
echo Look up your game name here: goo.gl/USKj5k
echo You'll have to enter the name of the Base rom later and you need to download the ini file.
echo If you have an INI file for your rom, place it now into the File Directory, if not, a blank ini will be used.
pause
cls
echo (Optional) Please put following files into the Files directory now. 
echo Otherwise the N64 VC INJECTION files will be used.
echo Icon file named iconTex.png OR iconTex.tga - Dimensions: 128x128
echo TV banner named bootTvTex.png OR bootTvTex.tga - Dimensions: 1280x720
echo 854x480 GamePad banner named bootDrcTex.png OR bootDrcTex.tga
pause
cls
echo Soon there will be more than the Paper Mario base rom, but for now, only the paper mario base rom.
pause
cd ..
cd ..
cd Files
move *.* ../Tools/N64/Source
cd ..
cd Tools
cd N64
cd Source
if exist *.ini rename *.ini user.ini
if exist *.v64 goto convert_v
if exist *.n64 goto convert_n
if exist *.z64 goto rename_z

:::::CONVERTING:::::
:convert_n
java -jar N64Converter.jar -i *.n64 -o game.z64
cd ..
goto papermarioeutitlekey
:convert_v
java -jar N64Converter.jar -i *.v64 -o game.z64
cd ..
goto papermarioeutitlekey

:::::RENAMEING:::::
:rename_z
rename *.z64 game.z64
cd ..
goto papermarioeutitlekey

:::::KEYS:::::
:wrongtkey
del /q Tools\Storage\PMEUKEY
echo Title Key is incorrect, try again
pause
cls
goto papermarioeutitlekey

:papermarioeutitlekey
set PMEUID=0005000010199800
IF NOT EXIST "Tools\Storage\PMEUKEY" set /p PMEUKEY=Enter or copypaste the eShop Title Key for Paper Mario [EUR] (Will not be required next time): >con
IF NOT EXIST "Tools\Storage\PMEUKEY" echo %PMEUKEY:~0,32%>Tools\Storage\PMEUKEY
set /p PMEUKEY=<Tools\Storage\PMEUKEY
cls
if not "%PMEUKEY:~0,4%"=="a694" goto:wrongtkey else goto commonpmeu

:commonpmeu
IF NOT EXIST "Tools\Storage\COMMONPMEU" set /p COMMONPMEU=Enter or copypaste the WiiU Commonkey (Will not be required next time): >con
IF NOT EXIST "Tools\Storage\COMMONPMEU" echo %COMMONPMEU:~0,32%>Tools\Storage\COMMONPMEU
set /p COMMONPMEU=<Tools\Storage\COMMONPMEU
echo http://ccs.cdn.wup.shop.nintendo.net/ccs/download>Tools\JNUSTool\config
echo %COMMONPMEU:~0,32%>>Tools\JNUSTool\config
echo https://tagaya.wup.shop.nintendo.net/tagaya/versionlist/EUR/EU/latest_version>>Tools\JNUSTool\config
echo https://tagaya-wup.cdn.nintendo.net/tagaya/versionlist/EUR/EU/list/%d.versionlist>>Tools\JNUSTool\config
goto download_pmeu

:::::DOWNLOAD:::::
:download_pmeu
cd Tools
cd JNUSTool
java -jar JNUSTool.jar %PMEUID% %PMEUKEY% -file /code/.*
cls
java -jar JNUSTool.jar %PMEUID% %PMEUKEY% -file /content/.*
cls
java -jar JNUSTool.jar %PMEUID% %PMEUKEY% -file /meta/bootMovie.h264
java -jar JNUSTool.jar %PMEUID% %PMEUKEY% -file /meta/meta.xml
java -jar JNUSTool.jar %PMEUID% %PMEUKEY% -file /meta/bootSound.btsnd
java -jar JNUSTool.jar %PMEUID% %PMEUKEY% -file /meta/Manual.bfma
cls
goto movefilespmeu

:::::MOVING:::::
:movefilespmeu
mkdir PMEU
cd "Paper Mario [NACP01]"
move code ../PMEU
move content ../PMEU
move meta ../PMEU
cd ..
cd ..
cd ..
goto checking_ini_pmeu

:::::CHECKING:::::
:checking_ini_pmeu
cd Source
if exist user.ini goto inject_ini_pmeu
if not exist user.ini goto use_blank_ini_pmeu
:::::INI STUFF:::::
:inject_ini_pmeu
rename user.ini UNMQP0.810.ini
cd ..
cd Tools
cd JNUSTool
cd PMEU
cd content
cd config
del /f /q UNMQP0.810.ini
cd ..
cd ..
cd ..
cd ..
cd ..
cd Source
move UNMQP0.810.ini ../Tools/JNUSTool/PMEU/content/config
goto inject_rom_pmeu

:use_blank_ini_pmeu
cd ..
cd Tools
cd JNUSTool
cd PMEU
cd content
cd config
del /f /q UNMQP0.810.ini
cd ..
cd ..
cd ..
cd .. 
cd Storage
cd GAME_FILES 
copy UNMQP0.810.ini ..\..\JNUSTool\PMEU\content\config
pause
cd ..
cd ..
cd ..
cd Source
goto inject_rom_pmeu

:::::INJECTING:::::
:inject_rom_pmeu
rename game.z64 UNMQP0.810
cd ..
cd Tools
cd JNUSTool
cd PMEU
cd content
cd rom
del /f /q UNMQP0.810
cd ..
cd ..
cd ..
cd ..
cd ..
cd Source
move UNMQP0.810 ../Tools/JNUSTool/PMEU/content/rom
goto movexml_pmeu

:::::XML STUFF:::::
:movexml_pmeu
cd ..
cd Tools
cd JNUSTool
cd PMEU
cd code
move app.xml ../../../../Source
cd ..
cd meta
move meta.xml ../../../../Source
cd ..
cd ..
cd ..
cd ..
cd Source
goto edit_appxml_pmeu

:edit_appxml_pmeu
set /p ID=Enter a 6-digit meta title ID you wish you use. Must only be HEX values. (0-F): >con
echo.>con
cls
start notepadplusplus.exe app.xml
cls
echo The app.xml will open now.
echo Please change the title id in line 6 to 000500001%ID%0
echo Press enter when saved
pause
cls
goto edit_metaxml_pmeu

:edit_metaxml_pmeu
cls
start notepadplusplus.exe meta.xml
cls
echo The meta.xml file will now open.
echo Please change the Product code (line 4)
echo Title Id to 000500001%ID%0 (line 18)
echo And the Long/shortnames to the Game name.
echo after you saved, press enter.
pause
cls
taskkill /f /im notepadplusplus.exe
goto moveback_xml_pmeu

:moveback_xml_pmeu
move app.xml ../Tools/JNUSTool/PMEU/code
move meta.xml ../Tools/JNUSTool/PMEU/meta
goto bootdrcpng_pmeu

:::::BOOT IMAGE FILES:::::
:bootdrcpng_pmeu
if exist bootDrcTex.png goto convertdrc_pmeu
if not exist bootDrcTex.png goto bootimageDRCtga_pmeu
:bootimageDRCtga_pmeu
if exist bootDrcTex.tga goto movedrc_pmeu
if not exist bootDrcTex.tga goto usetemplatedrc_pmeu
:bootdrcpng_pmeu
xcopy.exe  ..\Tools\Storage\GAME_FILES\bootDrcTex.tga ..\Tools\JNUSTool\PMEU\meta
cls
goto bootimageTVpng_pmeu
:convertdrc_pmeu
png2tgacmd.exe -i bootDrcTex.png -o ..\Tools\JNUSTool\PMEU\meta --width=854 --height=480 --tga-bpp=24 --tga-compression=none
cls
goto bootimageTVpng_pmeu
:movedrc_pmeu
move bootDrcTex.tga ../Tools/JNUSTool/PMEU/meta
cls
goto bootimageTVpng_pmeu
:bootimageTVpng_pmeu
if exist bootTvTex.png goto converttv_pmeu
if not exist bootTvTex.png goto bootimageTVtga_pmeu
:bootimageTVtga_pmeu
if exist bootTvTex.tga goto movetv_pmeu
if not exist bootTvTex.tga goto usetemplatetv_pmeu
:usetemplatetv_pmeu
xcopy.exe ..\Tools\Storage\GAME_FILES\bootTvTex.tga ..\Tools\JNUSTool\PMEU\meta
cls
goto bootimageIconpng_pmeu
:converttv_pmeu
png2tgacmd.exe -i bootTvTex.png -o ..\Tools\JNUSTool\PMEU\meta --width=1280 --height=720 --tga-bpp=24 --tga-compression=none
cls
goto bootimageIconpng_pmeu
:movetv_pmeu
move bootTvTex.tga ../Tools/JNUSTool/PMEU/meta
cls
goto bootimageIconpng_pmeu
:bootimageIconpng_pmeu
if exist iconTex.png goto moveicon_pmeu
if not exist iconText.png goto bootimageIcontga_pmeu
:bootimageIcontga_pmeu
if exist iconTex.tga goto moveicon_pmeu
if not exist iconTex.tga goto usetemplateicon_pmeu
:usetemplateicon_pmeu
xcopy.exe ..\Tools\Storage\GAME_FILES\iconTex.tga ..\Tools\JNUSTool\PMEU\meta
cls
goto usetemplatelogo_pmeu
:usetemplatedrc_pmeu
xcopy.exe ..Tools\Storage\GAME_FILES\bootDrcTex.tga ..\Tools\JNUSTool\PMEU\meta
cls
goto bootimageTVpng_pmeu
:converticon_pmeu
png2tgacmd.exe -i iconTex.png -o ..\Tools\JNUSTool\PMEU\meta --width=128 --height=128 --tga-bpp=32 --tga-compression=none
cls
goto usetemplatelogo_pmeu
:moveicon_pmeu
move iconTex.tga ../Tools/JNUSTool/PMEU/meta
cls
goto usetemplatelogo_pmeu
:usetemplatelogo_pmeu
xcopy.exe ..\Tools\Storage\GAME_FILES\bootLogoTex.tga ..\Tools\JNUSTool\PMEU\meta
cls
goto packing_pmeu

:::::PACKING:::::
:packing_pmeu
del /f /q *.png
cd ..
cd Tools
cd JNUSTool
cd PMEU
move code ../../NUSPACKER/input
move content ../../NUSPACKER/input
move meta ../../NUSPACKER/input
cd ..
rd /f /q PMEU
cd ..
cd NUSPACKER
start Pack_Games.bat
cls
echo if the Packer window closed, hit enter to finish the injection
pause
goto final

:::::final:::::
:final
cd install
move injected_vc_game ../../../../../Injected_Games
cd ..
cd input
rd /f /q code
rd /f /q content
rd /f /q meta
cls
echo have fun with your injected n64 game!
pause
exit

 