#include <idc.idc>

extern bin_output_dir;

// Assumes that the output directory exists and is writable
static dump_subcpu_modules(dir)
{
	auto fh;

	fh = fopen(sprintf("%s/sub_cpu_prog1.bin", dir), "wb");
	savefile(fh, 0, 0x16000, 0x4000);
	fclose(fh);

	fh = fopen(sprintf("%s/sub_cpu_prog2.bin", dir), "wb");
	savefile(fh, 0, 0x13400, 0x1C00);
	fclose(fh);

	fh = fopen(sprintf("%s/sub_cpu_prog3.bin", dir), "wb");
	savefile(fh, 0, 0x1A000, 0x6000);
	fclose(fh);
}

static main()
{
	auto fh;
	bin_output_dir = "../incbin";
	mkdir(bin_output_dir, 0755);
	dump_subcpu_modules(bin_output_dir);

	fh = fopen("testout.asm", "w");
	GenerateFile(OFILE_ASM, fh, 0x000000, 0x016000, 0);
	fclose(fh);
}
