#include <idc.idc>

extern bin_output_dir;

static main()
{
	bin_output_dir = "../bin";
	mkdir(bin_output_dir, 0755);
	
	auto module1 = sprintf("%s/rom_header.bin", bin_output_dir);
	auto fh = fopen(module1, "wb");
	if (fh == 0)
	{
		Warning(sprintf("Failed to open %d for writing!", module1));
		return;
	}
	savefile(fh, 0, 0x100, 0x100);
	fclose(fh);
	
	fh = fopen("testout.lst", "w");
	GenerateFile(OFILE_LST, fh, 0x426, 0x53B, 0);
	fclose(fh);
	
	fh = fopen("testout.asm", "w");
	GenerateFile(OFILE_ASM, fh, 0x426, 0x53B, 0);
	fclose(fh);
}
