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
cd ..
cd ..
cd Files
move *.* ../Tools/N64/Source
cd ..
cd Tools
cd N64
cd Source
if exist *.ini rename *.ini user.ini
cls
echo What Baserom are you wanting to use?
echo Paper Mario [EUR] (1)
echo F-Zero X (2)
set /p Baserom=Enter the number behind the base rom: 
if %Baserom%==1 goto checkingpmeu
if %Baserom%==2 goto checkingfz
:::::ROM CHECKING:::::
:checkingpmeu
if exist *.v64 goto convert_vpmeu
if exist *.n64 goto convert_npmeu
if exist *.z64 goto renamezp
:checkingfz
if exist *.v64 goto convert_vfz
if exist *.n64 goto convert_nfz
if exist *z64 goto rename_zfz
:::::CONVERTING:::::
:convert_npmeu
java -jar N64Converter.jar -i *.n64 -o game.z64
cd ..
goto papermarioeutitlekey
:convert_vpmeu
java -jar N64Converter.jar -i *.v64 -o game.z64
cd ..
goto papermarioeutitlekey
:convert_nfz
java -jar N64Converter.jar -i *.n64 -o game.z64
cd ..
goto fztitlekey
:convert_vfz
java -jar N64Converter.jar -i *.v64 -o game.z64
cd ..
goto fztitlekey
:::::RENAMEING:::::
:renamezp
rename *.z64 game.z64
cd ..
goto papermarioeutitlekey
:rename_zfz
rename *.z64 game.z64
cd ..
goto fztitlekey
:::::KEYS:::::
:wrongtkeypmeu
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
if not "%PMEUKEY:~0,4%"=="a694" goto:wrongtkeypmeu else goto commonpmeu

:commonpmeu
IF NOT EXIST "Tools\Storage\COMMONPMEU" set /p COMMONPMEU=Enter or copypaste the WiiU Commonkey (Will not be required next time): >con
IF NOT EXIST "Tools\Storage\COMMONPMEU" echo %COMMONPMEU:~0,32%>Tools\Storage\COMMONPMEU
set /p COMMONPMEU=<Tools\Storage\COMMONPMEU
echo http://ccs.cdn.wup.shop.nintendo.net/ccs/download>Tools\JNUSTool\config
echo %COMMONPMEU:~0,32%>>Tools\JNUSTool\config
echo https://tagaya.wup.shop.nintendo.net/tagaya/versionlist/EUR/EU/latest_version>>Tools\JNUSTool\config
echo https://tagaya-wup.cdn.nintendo.net/tagaya/versionlist/EUR/EU/list/%d.versionlist>>Tools\JNUSTool\config
goto download_pmeu

:wrongtkeyfz
del /q Tools\Storage\FZKEY
echo Title Key is incorrect, try again
pause
cls
goto fztitlekey

:fztitlekey
set FZID=00050000101ebc00
IF NOT EXIST "Tools\Storage\FZKEY" set /p FZKEY=Enter or copypaste the eShop Title Key for F-Zero X [USA] (Will not be required next time for this base rom): 
IF NOT EXIST "Tools\Storage\FZKEY" echo %FZKEY:~0,32%>Tools\Storage\FZKEY
set /p FZKEY=<Tools\Storage\FZKEY
cls
if not "%FZKEY:~0,4%"=="bfdb" goto:wrongtkeyfz else goto commonfz

:commonfz
IF NOT EXIST "Tools\Storage\COMMONFZ" set /p COMMONFZ=Enter or copypaste the WiiU Commonkey (Will not be required next time for this base rom): >con
IF NOT EXIST "Tools\Storage\COMMONFZ" echo %COMMONFZ:~0,32%>Tools\Storage\COMMONFZ
set /p COMMONFZ=<Tools\Storage\COMMONFZ
echo http://ccs.cdn.wup.shop.nintendo.net/ccs/download>Tools\JNUSTool\config
echo %COMMONFZ:~0,32%>>Tools\JNUSTool\config
echo https://tagaya.wup.shop.nintendo.net/tagaya/versionlist/EUR/EU/latest_version>>Tools\JNUSTool\config
echo https://tagaya-wup.cdn.nintendo.net/tagaya/versionlist/EUR/EU/list/%d.versionlist>>Tools\JNUSTool\config
goto download_fz
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

:download_fz
cd Tools
cd JNUSTool
java -jar JNUSTool.jar %FZID% %FZKEY% -file /code/.*
cls
java -jar JNUSTool.jar %FZID% %FZKEY% -file /content/.*
cls
java -jar JNUSTool.jar %FZID% %FZKEY% -file /meta/bootMovie.h264
java -jar JNUSTool.jar %FZID% %FZKEY% -file /meta/meta.xml
java -jar JNUSTool.jar %FZID% %FZKEY% -file /meta/bootSound.btsnd
java -jar JNUSTool.jar %FZID% %FZKEY% -file /meta/Manual.bfma
cls
goto movefilesfz
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

:movefilesfz
mkdir FZ
cd "F-Zero X [NAWE01]"
move code ../FZ
move content ../FZ
move meta ../FZ
cd ..
cd ..
cd ..
goto checking_ini_fz
:::::CHECKING:::::
:checking_ini_pmeu
cd Source
if exist user.ini goto inject_ini_pmeu
if not exist user.ini goto use_blank_ini_pmeu

:checking_ini_fz
cd Source 
if exist user.ini goto inject_ini_fz
if not exist user.ini goto use_blank_ini_fz
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

:inject_ini_fz
rename user.ini Ucfze0.242.ini
cd ..
cd Tools
cd FZ
cd content
cd config
del /f /q Ucfze0.242.ini
cd ..
cd ..
cd ..
cd ..
cd ..
cd Source
move Ucfze0.242.ini ../Tools/JNUSTool/FZ/content/config
goto inject_rom_fz

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
cd ..
cd ..
cd ..
cd Source
goto inject_rom_pmeu

:use_blank_ini_fz
cd ..
cd Tools
cd JNUSTool
cd FZ
cd content
cd config
del /f /q Ucfze0.242.ini
cd ..
cd ..
cd ..
cd .. 
cd Storage
cd GAME_FILES 
copy Ucfze0.242.ini ..\..\JNUSTool\FZ\content\config
pause
cd ..
cd ..
cd ..
cd Source
goto inject_rom_fz

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

:inject_rom_fz
rename game.z64 Ucfze0.242
cd ..
cd Tools
cd JNUSTool
cd FZ
cd content
cd rom
del /f /q Ucfze0.242
cd ..
cd ..
cd ..
cd ..
cd ..
cd Source
move Ucfze0.242 ../Tools/JNUSTool/FZ/content/rom
goto movexml_fz

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
echo ^<?xml version="1.0" encoding="utf-8"?^>>app.xml
echo ^<app type="complex" access="777"^>>>app.xml
echo   ^<version type="unsignedInt" length="4"^>16^</version^>>>app.xml
echo   ^<os_version type="hexBinary" length="8"^>000500101000400A^</os_version^>>>app.xml
echo   ^<title_id type="hexBinary" length="8"^>000500001%ID%0^</title_id^>>>app.xml
echo   ^<title_version type="hexBinary" length="2"^>0000^</title_version^>>>app.xml
echo   ^<sdk_version type="unsignedInt" length="4"^>21204^</sdk_version^>>>app.xml
echo   ^<app_type type="hexBinary" length="4"^>8000002E^</app_type^>>>app.xml
echo   ^<group_id type="hexBinary" length="4"^>00001EBC^</group_id^>>>app.xml
echo   ^<os_mask type="hexBinary" length="32"^>0000000000000000000000000000000000000000000000000000000000000000^</os_mask^>>>app.xml
echo   ^<common_id type="hexBinary" length="8"^>0000000000000000^</common_id^>>>app.xml
echo ^</app^>>>app.xml
cls
goto edit_metaxml_pmeu

:edit_metaxml_pmeu
cls
set /p PDC=Enter a 4-digit Product code (A-Z; 0-9): 
set /p Name=Enter the Game name:  
cls
echo ^<?xml version="1.0" encoding="utf-8"?^>>meta.xml
echo ^<menu type="complex" access="777"^>>>meta.xml
echo   ^<version type="unsignedInt" length="4"^>33^</version^>>>meta.xml
echo   ^<product_code type="string" length="32"^>WUP-N-%PDC%^</product_code^>>>meta.xml
echo   ^<content_platform type="string" length="32"^>WUP^</content_platform^>>>meta.xml
echo   ^<company_code type="string" length="8"^>0001^</company_code^>>>meta.xml
echo   ^<mastering_date type="string" length="32"^>^</mastering_date^>>>meta.xml
echo   ^<logo_type type="unsignedInt" length="4"^>0^</logo_type^>>>meta.xml
echo   ^<app_launch_type type="hexBinary" length="4"^>00000000^</app_launch_type^>>>meta.xml
echo   ^<invisible_flag type="hexBinary" length="4"^>00000000^</invisible_flag^>>>meta.xml
echo   ^<no_managed_flag type="hexBinary" length="4"^>00000000^</no_managed_flag^>>>meta.xml
echo   ^<no_event_log type="hexBinary" length="4"^>00000002^</no_event_log^>>>meta.xml
echo   ^<no_icon_database type="hexBinary" length="4"^>00000000^</no_icon_database^>>>meta.xml
echo   ^<launching_flag type="hexBinary" length="4"^>00000004^</launching_flag^>>>meta.xml
echo   ^<install_flag type="hexBinary" length="4"^>00000000^</install_flag^>>>meta.xml
echo   ^<closing_msg type="unsignedInt" length="4"^>0^</closing_msg^>>>meta.xml
echo   ^<title_version type="unsignedInt" length="4"^>0^</title_version^>>>meta.xml
echo   ^<title_id type="hexBinary" length="8"^>0005000010%ID%FF^</title_id^>>>meta.xml
echo   ^<group_id type="hexBinary" length="4"^>00001EBC^</group_id^>>>meta.xml
echo   ^<boss_id type="hexBinary" length="8"^>0000000000000000^</boss_id^>>>meta.xml
echo   ^<os_version type="hexBinary" length="8"^>000500101000400A^</os_version^>>>meta.xml
echo   ^<app_size type="hexBinary" length="8"^>0000000000000000^</app_size^>>>meta.xml
echo   ^<common_save_size type="hexBinary" length="8"^>0000000000000000^</common_save_size^>>>meta.xml
echo   ^<account_save_size type="hexBinary" length="8"^>0000000000000000^</account_save_size^>>>meta.xml
echo   ^<common_boss_size type="hexBinary" length="8"^>0000000000000000^</common_boss_size^>>>meta.xml
echo   ^<account_boss_size type="hexBinary" length="8"^>0000000000000000^</account_boss_size^>>>meta.xml
echo   ^<save_no_rollback type="unsignedInt" length="4"^>0^</save_no_rollback^>>>meta.xml
echo   ^<join_game_id type="hexBinary" length="4"^>00000000^</join_game_id^>>>meta.xml
echo   ^<join_game_mode_mask type="hexBinary" length="8"^>0000000000000000^</join_game_mode_mask^>>>meta.xml
echo   ^<bg_daemon_enable type="unsignedInt" length="4"^>0^</bg_daemon_enable^>>>meta.xml
echo   ^<olv_accesskey type="unsignedInt" length="4"^>3921400692^</olv_accesskey^>>>meta.xml
echo   ^<wood_tin type="unsignedInt" length="4"^>0^</wood_tin^>>>meta.xml
echo   ^<e_manual type="unsignedInt" length="4"^>0^</e_manual^>>>meta.xml
echo   ^<e_manual_version type="unsignedInt" length="4"^>0^</e_manual_version^>>>meta.xml
echo   ^<region type="hexBinary" length="4"^>00000002^</region^>>>meta.xml
echo   ^<pc_cero type="unsignedInt" length="4"^>128^</pc_cero^>>>meta.xml
echo   ^<pc_esrb type="unsignedInt" length="4"^>13^</pc_esrb^>>>meta.xml
echo   ^<pc_bbfc type="unsignedInt" length="4"^>192^</pc_bbfc^>>>meta.xml
echo   ^<pc_usk type="unsignedInt" length="4"^>128^</pc_usk^>>>meta.xml
echo   ^<pc_pegi_gen type="unsignedInt" length="4"^>128^</pc_pegi_gen^>>>meta.xml
echo   ^<pc_pegi_fin type="unsignedInt" length="4"^>192^</pc_pegi_fin^>>>meta.xml
echo   ^<pc_pegi_prt type="unsignedInt" length="4"^>128^</pc_pegi_prt^>>>meta.xml
echo   ^<pc_pegi_bbfc type="unsignedInt" length="4"^>128^</pc_pegi_bbfc^>>>meta.xml
echo   ^<pc_cob type="unsignedInt" length="4"^>128^</pc_cob^>>>meta.xml
echo   ^<pc_grb type="unsignedInt" length="4"^>128^</pc_grb^>>>meta.xml
echo   ^<pc_cgsrr type="unsignedInt" length="4"^>128^</pc_cgsrr^>>>meta.xml
echo   ^<pc_oflc type="unsignedInt" length="4"^>128^</pc_oflc^>>>meta.xml
echo   ^<pc_reserved0 type="unsignedInt" length="4"^>192^</pc_reserved0^>>>meta.xml
echo   ^<pc_reserved1 type="unsignedInt" length="4"^>192^</pc_reserved1^>>>meta.xml
echo   ^<pc_reserved2 type="unsignedInt" length="4"^>192^</pc_reserved2^>>>meta.xml
echo   ^<pc_reserved3 type="unsignedInt" length="4"^>192^</pc_reserved3^>>>meta.xml
echo   ^<ext_dev_nunchaku type="unsignedInt" length="4"^>0^</ext_dev_nunchaku^>>>meta.xml
echo   ^<ext_dev_classic type="unsignedInt" length="4"^>0^</ext_dev_classic^>>>meta.xml
echo   ^<ext_dev_urcc type="unsignedInt" length="4"^>0^</ext_dev_urcc^>>>meta.xml
echo   ^<ext_dev_board type="unsignedInt" length="4"^>0^</ext_dev_board^>>>meta.xml
echo   ^<ext_dev_usb_keyboard type="unsignedInt" length="4"^>0^</ext_dev_usb_keyboard^>>>meta.xml
echo   ^<ext_dev_etc type="unsignedInt" length="4"^>0^</ext_dev_etc^>>>meta.xml
echo   ^<ext_dev_etc_name type="string" length="512"^>^</ext_dev_etc_name^>>>meta.xml
echo   ^<eula_version type="unsignedInt" length="4"^>0^</eula_version^>>>meta.xml
echo   ^<drc_use type="unsignedInt" length="4"^>1^</drc_use^>>>meta.xml
echo   ^<network_use type="unsignedInt" length="4"^>0^</network_use^>>>meta.xml
echo   ^<online_account_use type="unsignedInt" length="4"^>0^</online_account_use^>>>meta.xml
echo   ^<direct_boot type="unsignedInt" length="4"^>0^</direct_boot^>>>meta.xml
echo   ^<reserved_flag0 type="hexBinary" length="4"^>00010001^</reserved_flag0^>>>meta.xml
echo   ^<reserved_flag1 type="hexBinary" length="4"^>00080023^</reserved_flag1^>>>meta.xml
echo   ^<reserved_flag2 type="hexBinary" length="4"^>53583445^</reserved_flag2^>>>meta.xml
echo   ^<reserved_flag3 type="hexBinary" length="4"^>00000000^</reserved_flag3^>>>meta.xml
echo   ^<reserved_flag4 type="hexBinary" length="4"^>00000000^</reserved_flag4^>>>meta.xml
echo   ^<reserved_flag5 type="hexBinary" length="4"^>00000000^</reserved_flag5^>>>meta.xml
echo   ^<reserved_flag6 type="hexBinary" length="4"^>00000003^</reserved_flag6^>>>meta.xml
echo   ^<reserved_flag7 type="hexBinary" length="4"^>00000005^</reserved_flag7^>>>meta.xml
echo   ^<longname_ja type="string" length="512"^>%Name%^</longname_ja^>>>meta.xml
echo   ^<longname_en type="string" length="512"^>%Name%^</longname_en^>>>meta.xml
echo   ^<longname_fr type="string" length="512"^>%Name%^</longname_fr^>>>meta.xml
echo   ^<longname_de type="string" length="512"^>%Name%^</longname_de^>>>meta.xml
echo   ^<longname_it type="string" length="512"^>%Name%^</longname_it^>>>meta.xml
echo   ^<longname_es type="string" length="512"^>%Name%^</longname_es^>>>meta.xml
echo   ^<longname_zhs type="string" length="512"^>%Name%^</longname_zhs^>>>meta.xml
echo   ^<longname_ko type="string" length="512"^>%Name%^</longname_ko^>>>meta.xml
echo   ^<longname_nl type="string" length="512"^>%Name%^</longname_nl^>>>meta.xml
echo   ^<longname_pt type="string" length="512"^>%Name%^</longname_pt^>>>meta.xml
echo   ^<longname_ru type="string" length="512"^>%Name%^</longname_ru^>>>meta.xml
echo   ^<longname_zht type="string" length="512"^>%Name%^</longname_zht^>>>meta.xml
echo   ^<shortname_ja type="string" length="256"^>%Name%^</shortname_ja^>>>meta.xml
echo   ^<shortname_en type="string" length="256"^>%Name%^</shortname_en^>>>meta.xml
echo   ^<shortname_fr type="string" length="256"^>%Name%^</shortname_fr^>>>meta.xml
echo   ^<shortname_de type="string" length="256"^>%Name%^</shortname_de^>>>meta.xml
echo   ^<shortname_it type="string" length="256"^>%Name%^</shortname_it^>>>meta.xml
echo   ^<shortname_es type="string" length="256"^>%Name%^</shortname_es^>>>meta.xml
echo   ^<shortname_zhs type="string" length="256"^>%Name%^</shortname_zhs^>>>meta.xml
echo   ^<shortname_ko type="string" length="256"^>%Name%^</shortname_ko^>>>meta.xml
echo   ^<shortname_nl type="string" length="256"^>%Name%^</shortname_nl^>>>meta.xml
echo   ^<shortname_pt type="string" length="256"^>%Name%^</shortname_pt^>>>meta.xml
echo   ^<shortname_ru type="string" length="256"^>%Name%^</shortname_ru^>>>meta.xml
echo   ^<shortname_zht type="string" length="256"^>%Name%^</shortname_zht^>>>meta.xml
echo   ^<publisher_ja type="string" length="256"^>NINTENDO^</publisher_ja^>>>meta.xml
echo   ^<publisher_en type="string" length="256"^>NINTENDO^</publisher_en^>>>meta.xml
echo   ^<publisher_fr type="string" length="256"^>NINTENDO^</publisher_fr^>>>meta.xml
echo   ^<publisher_de type="string" length="256"^>NINTENDO^</publisher_de^>>>meta.xml
echo   ^<publisher_it type="string" length="256"^>NINTENDO^</publisher_it^>>>meta.xml
echo   ^<publisher_es type="string" length="256"^>NINTENDO^</publisher_es^>>>meta.xml
echo   ^<publisher_zhs type="string" length="256"^>NINTENDO^</publisher_zhs^>>>meta.xml
echo   ^<publisher_ko type="string" length="256"^>NINTENDO^</publisher_ko^>>>meta.xml
echo   ^<publisher_nl type="string" length="256"^>NINTENDO^</publisher_nl^>>>meta.xml
echo   ^<publisher_pt type="string" length="256"^>NINTENDO^</publisher_pt^>>>meta.xml
echo   ^<publisher_ru type="string" length="256"^>NINTENDO^</publisher_ru^>>>meta.xml
echo   ^<publisher_zht type="string" length="256"^>NINTENDO^</publisher_zht^>>>meta.xml
echo   ^<add_on_unique_id0 type="hexBinary" length="4"^>00000000^</add_on_unique_id0^>>>meta.xml
echo   ^<add_on_unique_id1 type="hexBinary" length="4"^>00000000^</add_on_unique_id1^>>>meta.xml
echo   ^<add_on_unique_id2 type="hexBinary" length="4"^>00000000^</add_on_unique_id2^>>>meta.xml
echo   ^<add_on_unique_id3 type="hexBinary" length="4"^>00000000^</add_on_unique_id3^>>>meta.xml
echo   ^<add_on_unique_id4 type="hexBinary" length="4"^>00000000^</add_on_unique_id4^>>>meta.xml
echo   ^<add_on_unique_id5 type="hexBinary" length="4"^>00000000^</add_on_unique_id5^>>>meta.xml
echo   ^<add_on_unique_id6 type="hexBinary" length="4"^>00000000^</add_on_unique_id6^>>>meta.xml
echo   ^<add_on_unique_id7 type="hexBinary" length="4"^>00000000^</add_on_unique_id7^>>>meta.xml
echo   ^<add_on_unique_id8 type="hexBinary" length="4"^>00000000^</add_on_unique_id8^>>>meta.xml
echo   ^<add_on_unique_id9 type="hexBinary" length="4"^>00000000^</add_on_unique_id9^>>>meta.xml
echo   ^<add_on_unique_id10 type="hexBinary" length="4"^>00000000^</add_on_unique_id10^>>>meta.xml
echo   ^<add_on_unique_id11 type="hexBinary" length="4"^>00000000^</add_on_unique_id11^>>>meta.xml
echo   ^<add_on_unique_id12 type="hexBinary" length="4"^>00000000^</add_on_unique_id12^>>>meta.xml
echo   ^<add_on_unique_id13 type="hexBinary" length="4"^>00000000^</add_on_unique_id13^>>>meta.xml
echo   ^<add_on_unique_id14 type="hexBinary" length="4"^>00000000^</add_on_unique_id14^>>>meta.xml
echo   ^<add_on_unique_id15 type="hexBinary" length="4"^>00000000^</add_on_unique_id15^>>>meta.xml
echo   ^<add_on_unique_id16 type="hexBinary" length="4"^>00000000^</add_on_unique_id16^>>>meta.xml
echo   ^<add_on_unique_id17 type="hexBinary" length="4"^>00000000^</add_on_unique_id17^>>>meta.xml
echo   ^<add_on_unique_id18 type="hexBinary" length="4"^>00000000^</add_on_unique_id18^>>>meta.xml
echo   ^<add_on_unique_id19 type="hexBinary" length="4"^>00000000^</add_on_unique_id19^>>>meta.xml
echo   ^<add_on_unique_id20 type="hexBinary" length="4"^>00000000^</add_on_unique_id20^>>>meta.xml
echo   ^<add_on_unique_id21 type="hexBinary" length="4"^>00000000^</add_on_unique_id21^>>>meta.xml
echo   ^<add_on_unique_id22 type="hexBinary" length="4"^>00000000^</add_on_unique_id22^>>>meta.xml
echo   ^<add_on_unique_id23 type="hexBinary" length="4"^>00000000^</add_on_unique_id23^>>>meta.xml
echo   ^<add_on_unique_id24 type="hexBinary" length="4"^>00000000^</add_on_unique_id24^>>>meta.xml
echo   ^<add_on_unique_id25 type="hexBinary" length="4"^>00000000^</add_on_unique_id25^>>>meta.xml
echo   ^<add_on_unique_id26 type="hexBinary" length="4"^>00000000^</add_on_unique_id26^>>>meta.xml
echo   ^<add_on_unique_id27 type="hexBinary" length="4"^>00000000^</add_on_unique_id27^>>>meta.xml
echo   ^<add_on_unique_id28 type="hexBinary" length="4"^>00000000^</add_on_unique_id28^>>>meta.xml
echo   ^<add_on_unique_id29 type="hexBinary" length="4"^>00000000^</add_on_unique_id29^>>>meta.xml
echo   ^<add_on_unique_id30 type="hexBinary" length="4"^>00000000^</add_on_unique_id30^>>>meta.xml
echo   ^<add_on_unique_id31 type="hexBinary" length="4"^>00000000^</add_on_unique_id31^>>>meta.xml
echo ^</menu^>>>meta.xml
cls
goto moveback_xml_pmeu

:moveback_xml_pmeu
move app.xml ../Tools/JNUSTool/PMEU/code
move meta.xml ../Tools/JNUSTool/PMEU/meta
goto bootdrcpng_pmeu

:movexml_fz
cd ..
cd Tools
cd JNUSTool
cd FZ
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
goto edit_appxml_fz

:edit_appxml_fz
set /p ID=Enter a 6-digit meta title ID you wish you use. Must only be HEX values. (0-F): >con
echo.>con
cls
start notepadplusplus.exe app.xml
cls
echo ^<?xml version="1.0" encoding="utf-8"?^>>app.xml
echo ^<app type="complex" access="777"^>>>app.xml
echo   ^<version type="unsignedInt" length="4"^>16^</version^>>>app.xml
echo   ^<os_version type="hexBinary" length="8"^>000500101000400A^</os_version^>>>app.xml
echo   ^<title_id type="hexBinary" length="8"^>000500001%ID%0^</title_id^>>>app.xml
echo   ^<title_version type="hexBinary" length="2"^>0000^</title_version^>>>app.xml
echo   ^<sdk_version type="unsignedInt" length="4"^>21204^</sdk_version^>>>app.xml
echo   ^<app_type type="hexBinary" length="4"^>8000002E^</app_type^>>>app.xml
echo   ^<group_id type="hexBinary" length="4"^>00001EBC^</group_id^>>>app.xml
echo   ^<os_mask type="hexBinary" length="32"^>0000000000000000000000000000000000000000000000000000000000000000^</os_mask^>>>app.xml
echo   ^<common_id type="hexBinary" length="8"^>0000000000000000^</common_id^>>>app.xml
echo ^</app^>>>app.xml
pause
cls
goto edit_metaxml_fz

:edit_metaxml_fz
cls
start notepadplusplus.exe meta.xml
cls
echo ^<?xml version="1.0" encoding="utf-8"?^>>meta.xml
echo ^<menu type="complex" access="777"^>>>meta.xml
echo   ^<version type="unsignedInt" length="4"^>33^</version^>>>meta.xml
echo   ^<product_code type="string" length="32"^>WUP-N-%PDC%^</product_code^>>>meta.xml
echo   ^<content_platform type="string" length="32"^>WUP^</content_platform^>>>meta.xml
echo   ^<company_code type="string" length="8"^>0001^</company_code^>>>meta.xml
echo   ^<mastering_date type="string" length="32"^>^</mastering_date^>>>meta.xml
echo   ^<logo_type type="unsignedInt" length="4"^>0^</logo_type^>>>meta.xml
echo   ^<app_launch_type type="hexBinary" length="4"^>00000000^</app_launch_type^>>>meta.xml
echo   ^<invisible_flag type="hexBinary" length="4"^>00000000^</invisible_flag^>>>meta.xml
echo   ^<no_managed_flag type="hexBinary" length="4"^>00000000^</no_managed_flag^>>>meta.xml
echo   ^<no_event_log type="hexBinary" length="4"^>00000002^</no_event_log^>>>meta.xml
echo   ^<no_icon_database type="hexBinary" length="4"^>00000000^</no_icon_database^>>>meta.xml
echo   ^<launching_flag type="hexBinary" length="4"^>00000004^</launching_flag^>>>meta.xml
echo   ^<install_flag type="hexBinary" length="4"^>00000000^</install_flag^>>>meta.xml
echo   ^<closing_msg type="unsignedInt" length="4"^>0^</closing_msg^>>>meta.xml
echo   ^<title_version type="unsignedInt" length="4"^>0^</title_version^>>>meta.xml
echo   ^<title_id type="hexBinary" length="8"^>0005000010%ID%FF^</title_id^>>>meta.xml
echo   ^<group_id type="hexBinary" length="4"^>00001EBC^</group_id^>>>meta.xml
echo   ^<boss_id type="hexBinary" length="8"^>0000000000000000^</boss_id^>>>meta.xml
echo   ^<os_version type="hexBinary" length="8"^>000500101000400A^</os_version^>>>meta.xml
echo   ^<app_size type="hexBinary" length="8"^>0000000000000000^</app_size^>>>meta.xml
echo   ^<common_save_size type="hexBinary" length="8"^>0000000000000000^</common_save_size^>>>meta.xml
echo   ^<account_save_size type="hexBinary" length="8"^>0000000000000000^</account_save_size^>>>meta.xml
echo   ^<common_boss_size type="hexBinary" length="8"^>0000000000000000^</common_boss_size^>>>meta.xml
echo   ^<account_boss_size type="hexBinary" length="8"^>0000000000000000^</account_boss_size^>>>meta.xml
echo   ^<save_no_rollback type="unsignedInt" length="4"^>0^</save_no_rollback^>>>meta.xml
echo   ^<join_game_id type="hexBinary" length="4"^>00000000^</join_game_id^>>>meta.xml
echo   ^<join_game_mode_mask type="hexBinary" length="8"^>0000000000000000^</join_game_mode_mask^>>>meta.xml
echo   ^<bg_daemon_enable type="unsignedInt" length="4"^>0^</bg_daemon_enable^>>>meta.xml
echo   ^<olv_accesskey type="unsignedInt" length="4"^>3921400692^</olv_accesskey^>>>meta.xml
echo   ^<wood_tin type="unsignedInt" length="4"^>0^</wood_tin^>>>meta.xml
echo   ^<e_manual type="unsignedInt" length="4"^>0^</e_manual^>>>meta.xml
echo   ^<e_manual_version type="unsignedInt" length="4"^>0^</e_manual_version^>>>meta.xml
echo   ^<region type="hexBinary" length="4"^>00000002^</region^>>>meta.xml
echo   ^<pc_cero type="unsignedInt" length="4"^>128^</pc_cero^>>>meta.xml
echo   ^<pc_esrb type="unsignedInt" length="4"^>13^</pc_esrb^>>>meta.xml
echo   ^<pc_bbfc type="unsignedInt" length="4"^>192^</pc_bbfc^>>>meta.xml
echo   ^<pc_usk type="unsignedInt" length="4"^>128^</pc_usk^>>>meta.xml
echo   ^<pc_pegi_gen type="unsignedInt" length="4"^>128^</pc_pegi_gen^>>>meta.xml
echo   ^<pc_pegi_fin type="unsignedInt" length="4"^>192^</pc_pegi_fin^>>>meta.xml
echo   ^<pc_pegi_prt type="unsignedInt" length="4"^>128^</pc_pegi_prt^>>>meta.xml
echo   ^<pc_pegi_bbfc type="unsignedInt" length="4"^>128^</pc_pegi_bbfc^>>>meta.xml
echo   ^<pc_cob type="unsignedInt" length="4"^>128^</pc_cob^>>>meta.xml
echo   ^<pc_grb type="unsignedInt" length="4"^>128^</pc_grb^>>>meta.xml
echo   ^<pc_cgsrr type="unsignedInt" length="4"^>128^</pc_cgsrr^>>>meta.xml
echo   ^<pc_oflc type="unsignedInt" length="4"^>128^</pc_oflc^>>>meta.xml
echo   ^<pc_reserved0 type="unsignedInt" length="4"^>192^</pc_reserved0^>>>meta.xml
echo   ^<pc_reserved1 type="unsignedInt" length="4"^>192^</pc_reserved1^>>>meta.xml
echo   ^<pc_reserved2 type="unsignedInt" length="4"^>192^</pc_reserved2^>>>meta.xml
echo   ^<pc_reserved3 type="unsignedInt" length="4"^>192^</pc_reserved3^>>>meta.xml
echo   ^<ext_dev_nunchaku type="unsignedInt" length="4"^>0^</ext_dev_nunchaku^>>>meta.xml
echo   ^<ext_dev_classic type="unsignedInt" length="4"^>0^</ext_dev_classic^>>>meta.xml
echo   ^<ext_dev_urcc type="unsignedInt" length="4"^>0^</ext_dev_urcc^>>>meta.xml
echo   ^<ext_dev_board type="unsignedInt" length="4"^>0^</ext_dev_board^>>>meta.xml
echo   ^<ext_dev_usb_keyboard type="unsignedInt" length="4"^>0^</ext_dev_usb_keyboard^>>>meta.xml
echo   ^<ext_dev_etc type="unsignedInt" length="4"^>0^</ext_dev_etc^>>>meta.xml
echo   ^<ext_dev_etc_name type="string" length="512"^>^</ext_dev_etc_name^>>>meta.xml
echo   ^<eula_version type="unsignedInt" length="4"^>0^</eula_version^>>>meta.xml
echo   ^<drc_use type="unsignedInt" length="4"^>1^</drc_use^>>>meta.xml
echo   ^<network_use type="unsignedInt" length="4"^>0^</network_use^>>>meta.xml
echo   ^<online_account_use type="unsignedInt" length="4"^>0^</online_account_use^>>>meta.xml
echo   ^<direct_boot type="unsignedInt" length="4"^>0^</direct_boot^>>>meta.xml
echo   ^<reserved_flag0 type="hexBinary" length="4"^>00010001^</reserved_flag0^>>>meta.xml
echo   ^<reserved_flag1 type="hexBinary" length="4"^>00080023^</reserved_flag1^>>>meta.xml
echo   ^<reserved_flag2 type="hexBinary" length="4"^>53583445^</reserved_flag2^>>>meta.xml
echo   ^<reserved_flag3 type="hexBinary" length="4"^>00000000^</reserved_flag3^>>>meta.xml
echo   ^<reserved_flag4 type="hexBinary" length="4"^>00000000^</reserved_flag4^>>>meta.xml
echo   ^<reserved_flag5 type="hexBinary" length="4"^>00000000^</reserved_flag5^>>>meta.xml
echo   ^<reserved_flag6 type="hexBinary" length="4"^>00000003^</reserved_flag6^>>>meta.xml
echo   ^<reserved_flag7 type="hexBinary" length="4"^>00000005^</reserved_flag7^>>>meta.xml
echo   ^<longname_ja type="string" length="512"^>%Name%^</longname_ja^>>>meta.xml
echo   ^<longname_en type="string" length="512"^>%Name%^</longname_en^>>>meta.xml
echo   ^<longname_fr type="string" length="512"^>%Name%^</longname_fr^>>>meta.xml
echo   ^<longname_de type="string" length="512"^>%Name%^</longname_de^>>>meta.xml
echo   ^<longname_it type="string" length="512"^>%Name%^</longname_it^>>>meta.xml
echo   ^<longname_es type="string" length="512"^>%Name%^</longname_es^>>>meta.xml
echo   ^<longname_zhs type="string" length="512"^>%Name%^</longname_zhs^>>>meta.xml
echo   ^<longname_ko type="string" length="512"^>%Name%^</longname_ko^>>>meta.xml
echo   ^<longname_nl type="string" length="512"^>%Name%^</longname_nl^>>>meta.xml
echo   ^<longname_pt type="string" length="512"^>%Name%^</longname_pt^>>>meta.xml
echo   ^<longname_ru type="string" length="512"^>%Name%^</longname_ru^>>>meta.xml
echo   ^<longname_zht type="string" length="512"^>%Name%^</longname_zht^>>>meta.xml
echo   ^<shortname_ja type="string" length="256"^>%Name%^</shortname_ja^>>>meta.xml
echo   ^<shortname_en type="string" length="256"^>%Name%^</shortname_en^>>>meta.xml
echo   ^<shortname_fr type="string" length="256"^>%Name%^</shortname_fr^>>>meta.xml
echo   ^<shortname_de type="string" length="256"^>%Name%^</shortname_de^>>>meta.xml
echo   ^<shortname_it type="string" length="256"^>%Name%^</shortname_it^>>>meta.xml
echo   ^<shortname_es type="string" length="256"^>%Name%^</shortname_es^>>>meta.xml
echo   ^<shortname_zhs type="string" length="256"^>%Name%^</shortname_zhs^>>>meta.xml
echo   ^<shortname_ko type="string" length="256"^>%Name%^</shortname_ko^>>>meta.xml
echo   ^<shortname_nl type="string" length="256"^>%Name%^</shortname_nl^>>>meta.xml
echo   ^<shortname_pt type="string" length="256"^>%Name%^</shortname_pt^>>>meta.xml
echo   ^<shortname_ru type="string" length="256"^>%Name%^</shortname_ru^>>>meta.xml
echo   ^<shortname_zht type="string" length="256"^>%Name%^</shortname_zht^>>>meta.xml
echo   ^<publisher_ja type="string" length="256"^>NINTENDO^</publisher_ja^>>>meta.xml
echo   ^<publisher_en type="string" length="256"^>NINTENDO^</publisher_en^>>>meta.xml
echo   ^<publisher_fr type="string" length="256"^>NINTENDO^</publisher_fr^>>>meta.xml
echo   ^<publisher_de type="string" length="256"^>NINTENDO^</publisher_de^>>>meta.xml
echo   ^<publisher_it type="string" length="256"^>NINTENDO^</publisher_it^>>>meta.xml
echo   ^<publisher_es type="string" length="256"^>NINTENDO^</publisher_es^>>>meta.xml
echo   ^<publisher_zhs type="string" length="256"^>NINTENDO^</publisher_zhs^>>>meta.xml
echo   ^<publisher_ko type="string" length="256"^>NINTENDO^</publisher_ko^>>>meta.xml
echo   ^<publisher_nl type="string" length="256"^>NINTENDO^</publisher_nl^>>>meta.xml
echo   ^<publisher_pt type="string" length="256"^>NINTENDO^</publisher_pt^>>>meta.xml
echo   ^<publisher_ru type="string" length="256"^>NINTENDO^</publisher_ru^>>>meta.xml
echo   ^<publisher_zht type="string" length="256"^>NINTENDO^</publisher_zht^>>>meta.xml
echo   ^<add_on_unique_id0 type="hexBinary" length="4"^>00000000^</add_on_unique_id0^>>>meta.xml
echo   ^<add_on_unique_id1 type="hexBinary" length="4"^>00000000^</add_on_unique_id1^>>>meta.xml
echo   ^<add_on_unique_id2 type="hexBinary" length="4"^>00000000^</add_on_unique_id2^>>>meta.xml
echo   ^<add_on_unique_id3 type="hexBinary" length="4"^>00000000^</add_on_unique_id3^>>>meta.xml
echo   ^<add_on_unique_id4 type="hexBinary" length="4"^>00000000^</add_on_unique_id4^>>>meta.xml
echo   ^<add_on_unique_id5 type="hexBinary" length="4"^>00000000^</add_on_unique_id5^>>>meta.xml
echo   ^<add_on_unique_id6 type="hexBinary" length="4"^>00000000^</add_on_unique_id6^>>>meta.xml
echo   ^<add_on_unique_id7 type="hexBinary" length="4"^>00000000^</add_on_unique_id7^>>>meta.xml
echo   ^<add_on_unique_id8 type="hexBinary" length="4"^>00000000^</add_on_unique_id8^>>>meta.xml
echo   ^<add_on_unique_id9 type="hexBinary" length="4"^>00000000^</add_on_unique_id9^>>>meta.xml
echo   ^<add_on_unique_id10 type="hexBinary" length="4"^>00000000^</add_on_unique_id10^>>>meta.xml
echo   ^<add_on_unique_id11 type="hexBinary" length="4"^>00000000^</add_on_unique_id11^>>>meta.xml
echo   ^<add_on_unique_id12 type="hexBinary" length="4"^>00000000^</add_on_unique_id12^>>>meta.xml
echo   ^<add_on_unique_id13 type="hexBinary" length="4"^>00000000^</add_on_unique_id13^>>>meta.xml
echo   ^<add_on_unique_id14 type="hexBinary" length="4"^>00000000^</add_on_unique_id14^>>>meta.xml
echo   ^<add_on_unique_id15 type="hexBinary" length="4"^>00000000^</add_on_unique_id15^>>>meta.xml
echo   ^<add_on_unique_id16 type="hexBinary" length="4"^>00000000^</add_on_unique_id16^>>>meta.xml
echo   ^<add_on_unique_id17 type="hexBinary" length="4"^>00000000^</add_on_unique_id17^>>>meta.xml
echo   ^<add_on_unique_id18 type="hexBinary" length="4"^>00000000^</add_on_unique_id18^>>>meta.xml
echo   ^<add_on_unique_id19 type="hexBinary" length="4"^>00000000^</add_on_unique_id19^>>>meta.xml
echo   ^<add_on_unique_id20 type="hexBinary" length="4"^>00000000^</add_on_unique_id20^>>>meta.xml
echo   ^<add_on_unique_id21 type="hexBinary" length="4"^>00000000^</add_on_unique_id21^>>>meta.xml
echo   ^<add_on_unique_id22 type="hexBinary" length="4"^>00000000^</add_on_unique_id22^>>>meta.xml
echo   ^<add_on_unique_id23 type="hexBinary" length="4"^>00000000^</add_on_unique_id23^>>>meta.xml
echo   ^<add_on_unique_id24 type="hexBinary" length="4"^>00000000^</add_on_unique_id24^>>>meta.xml
echo   ^<add_on_unique_id25 type="hexBinary" length="4"^>00000000^</add_on_unique_id25^>>>meta.xml
echo   ^<add_on_unique_id26 type="hexBinary" length="4"^>00000000^</add_on_unique_id26^>>>meta.xml
echo   ^<add_on_unique_id27 type="hexBinary" length="4"^>00000000^</add_on_unique_id27^>>>meta.xml
echo   ^<add_on_unique_id28 type="hexBinary" length="4"^>00000000^</add_on_unique_id28^>>>meta.xml
echo   ^<add_on_unique_id29 type="hexBinary" length="4"^>00000000^</add_on_unique_id29^>>>meta.xml
echo   ^<add_on_unique_id30 type="hexBinary" length="4"^>00000000^</add_on_unique_id30^>>>meta.xml
echo   ^<add_on_unique_id31 type="hexBinary" length="4"^>00000000^</add_on_unique_id31^>>>meta.xml
echo ^</menu^>>>meta.xml
cls
goto moveback_xml_fz

:moveback_xml_fz
move app.xml ../Tools/JNUSTool/FZ/code
move meta.xml ../Tools/JNUSTool/FZ/meta
goto bootdrcpng_fz

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
::::FZ::::
:bootdrcpng_fz
if exist bootDrcTex.png goto convertdrc_fz
if not exist bootDrcTex.png goto bootimageDRCtga_fz
:bootimageDRCtga_fz
if exist bootDrcTex.tga goto movedrc_fz
if not exist bootDrcTex.tga goto usetemplatedrc_fz
:bootdrcpng_fz
xcopy.exe  ..\Tools\Storage\GAME_FILES\bootDrcTex.tga ..\Tools\JNUSTool\FZ\meta
cls
goto bootimageTVpng_fz
:convertdrc_fz
png2tgacmd.exe -i bootDrcTex.png -o ..\Tools\JNUSTool\FZ\meta --width=854 --height=480 --tga-bpp=24 --tga-compression=none
cls
goto bootimageTVpng_fz
:movedrc_fz
move bootDrcTex.tga ../Tools/JNUSTool/FZ/meta
cls
goto bootimageTVpng_fz
:bootimageTVpng_fz
if exist bootTvTex.png goto converttv_fz
if not exist bootTvTex.png goto bootimageTVtga_fz
:bootimageTVtga_fz
if exist bootTvTex.tga goto movetv_fz
if not exist bootTvTex.tga goto usetemplatetv_fz
:usetemplatetv_fz
xcopy.exe ..\Tools\Storage\GAME_FILES\bootTvTex.tga ..\Tools\JNUSTool\FZ\meta
cls
goto bootimageIconpng_fz
:converttv_fz
png2tgacmd.exe -i bootTvTex.png -o ..\Tools\JNUSTool\FZ\meta --width=1280 --height=720 --tga-bpp=24 --tga-compression=none
cls
goto bootimageIconpng_fz
:movetv_fz
move bootTvTex.tga ../Tools/JNUSTool/FZ/meta
cls
goto bootimageIconpng_fz
:bootimageIconpng_fz
if exist iconTex.png goto moveicon_fz
if not exist iconText.png goto bootimageIcontga_fz
:bootimageIcontga_fz
if exist iconTex.tga goto moveicon_fz
if not exist iconTex.tga goto usetemplateicon_fz
:usetemplateicon_fz
xcopy.exe ..\Tools\Storage\GAME_FILES\iconTex.tga ..\Tools\JNUSTool\FZ\meta
cls
goto usetemplatelogo_fz
:usetemplatedrc_fz
xcopy.exe ..Tools\Storage\GAME_FILES\bootDrcTex.tga ..\Tools\JNUSTool\FZ\meta
cls
goto bootimageTVpng_fz
:converticon_fz
png2tgacmd.exe -i iconTex.png -o ..\Tools\JNUSTool\FZ\meta --width=128 --height=128 --tga-bpp=32 --tga-compression=none
cls
goto usetemplatelogo_fz
:moveicon_fz
move iconTex.tga ../Tools/JNUSTool/FZ/meta
cls
goto usetemplatelogo_fz
:usetemplatelogo_fz
xcopy.exe ..\Tools\Storage\GAME_FILES\bootLogoTex.tga ..\Tools\JNUSTool\FZ\meta
cls
goto packing_fz

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

:packing_fz
del /f /q *.png
cd ..
cd Tools
cd JNUSTool
cd FZ
move code ../../NUSPACKER/input
move content ../../NUSPACKER/input
move meta ../../NUSPACKER/input
cd ..
rd /f /q FZ
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

 