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

static dump_z80_modules(dir)
{
	auto fh;

	fh = fopen(sprintf("%s/z80_prog1.bin", dir), "wb");
	savefile(fh, 0, 0xF000, 0xCA0);
	fclose(fh);

	fh = fopen(sprintf("%s/z80_prog2.bin", dir), "wb");
	savefile(fh, 0, 0xFCA0, 0x17A);
	fclose(fh);

	fh = fopen(sprintf("%s/z80_prog3.bin", dir), "wb");
	savefile(fh, 0, 0xFE1A, 0x4BA);
	fclose(fh);
}

static dump_boot_blocks(dir)
{
	auto fh;

	fh = fopen(sprintf("%s/cart_boot_block.bin", dir), "wb");
	savefile(fh, 0, 0x6DEE, 0x586);
	fclose(fh);
}

static main()
{
	auto fh;
	bin_output_dir = "../incbin";
	mkdir(bin_output_dir, 0755);

	dump_boot_blocks(bin_output_dir);
	dump_z80_modules(bin_output_dir);
	dump_subcpu_modules(bin_output_dir);

	fh = fopen("testout.asm", "w");
	GenerateFile(OFILE_ASM, fh, 0x000000, 0x016000, 0);
	fclose(fh);
}
