@echo off
java -jar NUSPacker.jar -in input -out output -encryptKeyWith D7B00402659BA2ABD2CB0DB27FA2B656
rd /s /q tmp
mkdir install
cd install
mkdir injected_vc_game
cd ..
cd output
move *.* ..\install\injected_vc_game
cd ..
rd /s /q output
exit 0