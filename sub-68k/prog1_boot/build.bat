@ECHO OFF

SET ASM=..\..\bin\asm68k.exe
SET ASMOPTS=/j "include\*" /j "incbin\*" /j "..\common\*" /p /o c+,op+,os+,ow+,ws+ /m
SET INFILE=prog1_boot.asm
SET OUTFILE=prog1_boot

ECHO Building Sub CPU program 1 (BOOT)...
%ASM% %ASMOPTS% %INFILE%,%OUTFILE%.smd,%OUTFILE%.sym,%OUTFILE%.l68
