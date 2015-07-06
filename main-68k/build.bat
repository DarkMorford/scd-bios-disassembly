@ECHO OFF

SET ASM=..\bin\asm68k.exe
SET ASMOPTS=/j "include\*" /j "incbin\*" /p /o c+,ws+,ow+
SET INFILE=bios_main.asm
SET OUTFILE=bios_main_build

ECHO Building Main CPU program...
%ASM% %ASMOPTS% %INFILE%,%OUTFILE%.smd,%OUTFILE%.sym,%OUTFILE%.lst
