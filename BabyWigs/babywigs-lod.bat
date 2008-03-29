@echo off

cd ..
rmdir /s /q BabyWigs_Deadmines

cd BabyWigs

move Deadmines ..\BabyWigs_Deadmines

del /q modules.xml

