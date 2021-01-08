#!/bin/bash -x

CHIPSET_NAME=kona
VARIANT=$1
VERSION=$2

rm -rf out

#ccache -M 4.5

export ARCH=arm64

make mrproper

mkdir out

DTS_DIR=$(pwd)/out/arch/$ARCH/boot/dts
BUILD_CROSS_COMPILE=$(pwd)/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
#KERNEL_LLVM_BIN=$(pwd)/toolchain/llvm-arm-toolchain-ship/8.0/bin/clang
#KERNEL_LLVM_BIN=../toolchains/llvm/bin/clang
KERNEL_LLVM_BIN=clang
CLANG_TRIPLE=aarch64-linux-gnu-

KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y VARIANT_DEFCONFIG=vendor/variant_$1_defconfig"

# If not cleaning the tree between builds, the following command will be
# required on 2nd and subsequent builds to prevent a huge slowdown of the
# build.
#
# find techpack -type f -name \*.o | xargs rm -f


#make $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN vendor/z3q_kor_singlex_defconfig

make O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN vendor/jimbok_defconfig

make -j$(nproc) O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN


cp $(pwd)/out/arch/$ARCH/boot/Image $(pwd)/out/Image
cat ${DTS_DIR}/vendor/qcom/*.dtb > $(pwd)/out/dtb.img
DTBO_FILES=$(find ${DTS_DIR}/samsung/ -name ${CHIPSET_NAME}-sec-*-r*.dtbo)
$(pwd)/tools/mkdtimg create $(pwd)/out/dtbo.img --page_size=4096 ${DTBO_FILES}
mv $(pwd)/out/Image $(pwd)/out/Image-JimboK_$1

mv $(pwd)/out/dtb.img $(pwd)/out/dtb-JimboK_$1.img

cp $(pwd)/out/Image-JimboK_$1 ~/build/mkbootimg-master2
cp $(pwd)/out/dtb-JimboK_$1.img ~/build/mkbootimg-master2

~/build/mkbootimg-master2/make_boot_$1.sh $2-$1
