@ECHO OFF

SET ASM=..\..\bin\asm68k.exe
SET ASMOPTS=/j "include\*" /j "incbin\*" /j "..\common\*" /p /o c+,op+,os+,ow+,ws+ /m
SET INFILE=sub_prog0.asm
SET OUTFILE=sub_prog0

ECHO Building Sub CPU program 0...
%ASM% %ASMOPTS% %INFILE%,%OUTFILE%.smd,%OUTFILE%.sym,%OUTFILE%.lst
