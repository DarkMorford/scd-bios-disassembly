@ECHO OFF

SET ASM=..\..\bin\asm68k.exe
SET ASMOPTS=/j "include\*" /j "incbin\*" /j "..\common\*" /p /o c+,op+,os+,ow+,ws+ /m
SET INFILE=prog2_player.asm
SET OUTFILE=prog2_player

ECHO Building Sub CPU program 2 (PLAYER)...
%ASM% %ASMOPTS% %INFILE%,%OUTFILE%.smd,%OUTFILE%.sym,%OUTFILE%.L68
