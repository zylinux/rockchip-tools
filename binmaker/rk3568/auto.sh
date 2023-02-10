#!/bin/bash

set -e

CREATE_MASKROM_LOADER_BIN()
{
	./tools/boot_merger ./RK3568MINIALL.ini
	mv rk356x_spl_loader_v1.13.112.bin rk3568_offical_maskrom_loader.bin
	
	echo "rk3568_offical_maskrom_loader.bin is ok to use!"
}

CREATE_MASKROM_LOADER_BIN
