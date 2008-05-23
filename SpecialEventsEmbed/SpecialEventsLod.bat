@echo off

cd ..
rmdir /s /q SpecialEvents-Aura-2.0
rmdir /s /q SpecialEvents-Bags-2.0
rmdir /s /q SpecialEvents-Equipped-2.0
rmdir /s /q SpecialEvents-LearnSpell-2.0
rmdir /s /q SpecialEvents-Loot-1.0
rmdir /s /q SpecialEvents-Mail-2.0
rmdir /s /q SpecialEvents-Mount-2.0
rmdir /s /q SpecialEvents-Movement-2.0

cd SpecialEventsEmbed

move SpecialEvents-Aura-2.0 ..\SpecialEvents-Aura-2.0
move SpecialEvents-Bags-2.0 ..\SpecialEvents-Bags-2.0
move SpecialEvents-Equipped-2.0 ..\SpecialEvents-Equipped-2.0
move SpecialEvents-LearnSpell-2.0 ..\SpecialEvents-LearnSpell-2.0
move SpecialEvents-Loot-1.0 ..\SpecialEvents-Loot-1.0
move SpecialEvents-Mail-2.0 ..\SpecialEvents-Mail-2.0
move SpecialEvents-Mount-2.0 ..\SpecialEvents-Mount-2.0
move SpecialEvents-Movement-2.0 ..\SpecialEvents-Movement-2.0