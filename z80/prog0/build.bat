@ECHO OFF
CLS

SET ASM=..\..\bin\zmac.exe
SET ASMOPTS=-I ..\common -I include
SET INFILE=z80_prog0.z

ECHO Building Z80 program 0...
%ASM% %ASMOPTS% %INFILE%

ECHO.
md5sum *.bin
md5sum zout/*.cim
