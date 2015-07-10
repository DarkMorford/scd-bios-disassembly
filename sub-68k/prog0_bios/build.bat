@ECHO OFF

SET ASM=..\..\bin\asm68k.exe
SET ASMOPTS=/j "include\*" /j "incbin\*" /j "..\common\*" /p /o c+,op+,os+,ow+,ws+ /m
SET INFILE=prog0_bios.asm
SET OUTFILE=prog0_bios

ECHO Building Sub CPU program 0 (BIOS)...
%ASM% %ASMOPTS% %INFILE%,%OUTFILE%.smd,%OUTFILE%.sym,%OUTFILE%.L68
