#!/bin/bash

set -e

CREATE_MASKROM_LOADER_BIN()
{
	./tools/boot_merger ./RK3568MINIALL.ini
	mv rk356x_spl_loader_v1.13.112.bin output/rk3568_offical_maskrom_loader.bin
	
	echo "rk3568_offical_maskrom_loader.bin is ok to use!"
}

CREATE_UBOOT_REQUIREDBINS()
{
	#first, go back to your uboot folder run ./make.sh itb ../rkbin/RKTRUST/RK3568TRUST.ini to get u-boot.its
	##uboot will do below comments
	##cp ./bin/rk35/rk3568_bl31_v1.33.elf bl31.elf
	##cp ./bin/rk35/rk3568_bl32_v2.08.bin tee.bin
	##arch/arm/mach-rockchip/make_fit_atf.sh -t 0x08400000 > u-boot.its
	
	#second, i copied uboot/tools/mkimage and all bins we needed from uboot folder
	##cp uboot/tools/mkimage tools/
	##cp u-boot.its ./binmaker/rk3568/uboot/
	##cp u-boot-nodtb.bin ./binmaker/rk3568/uboot/
	##cp bl31_0x00040000.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp bl31_0xfdcc1000.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp bl31_0x0006a000.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp bl31_0xfdcd0000.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp bl31_0xfdcce000.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp bl31_0x00068000.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp tee.bin ../rockchip-tools/binmaker/rk3568/uboot/
	##cp u-boot.dtb ../rockchip-tools/binmaker/rk3568/uboot/
	./tools/mkimage -f uboot/u-boot.its -E output/u-boot.itb
}

CREATE_UBOOT_IMG()
{
	rm -f uboot.img
	for ((i = 0; i < 2; i++));
	do
		cat output/u-boot.itb >> output/uboot.img
		truncate -s %2048K output/uboot.img
	done

}

CLEAN_ALL()
{
	rm -rf output/*
}

CLEAN_ALL
CREATE_MASKROM_LOADER_BIN
CREATE_UBOOT_REQUIREDBINS
CREATE_UBOOT_IMG

