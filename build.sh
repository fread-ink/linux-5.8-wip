
#!/bin/sh

# created by juul

set -e

objcopy -I ihex -O binary firmware/imx/sdma/sdma-imx50.bin.ihex firmware/imx/sdma/sdma-imx50.bin

#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- imx50_kindle4nt_defconfig

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j 8

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- dtbs

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOADADDR=0x70800000 uImage

mkdir -p OUTPUT

cp arch/arm/boot/zImage OUTPUT/
cp arch/arm/boot/uImage OUTPUT/
cp arch/arm/boot/dts/imx50-kindle4nt.dtb OUTPUT/

cd OUTPUT/
cat zImage imx50-kindle4nt.dtb > zImage_with_dtb
cat uImage imx50-kindle4nt.dtb > uImage_with_dtb
#mkimage -a 0x70800000 -d uImage uImage_with_dtb

#cp linux-2.6.31-rt11-lab126.tar.gz OUTPUT/
#cp modules.dep OUTPUT/

echo " "
echo "Build complete. Find the results in the OUTPUT/ dir."
