#!/bin/bash -x

export ARCH=arm64

make mrproper

mkdir out

DTS_DIR=$(pwd)/out/arch/$ARCH/boot/dts
BUILD_CROSS_COMPILE=$(pwd)/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
#KERNEL_LLVM_BIN=$(pwd)/toolchain/llvm-arm-toolchain-ship/8.0/bin/clang
#KERNEL_LLVM_BIN=../toolchains/llvm/bin/clang
KERNEL_LLVM_BIN=clang
CLANG_TRIPLE=aarch64-linux-gnu-

KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

# If not cleaning the tree between builds, the following command will be
# required on 2nd and subsequent builds to prevent a huge slowdown of the
# build.
#
# find techpack -type f -name \*.o | xargs rm -f


#make $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN vendor/z3q_kor_singlex_defconfig

make O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN vendor/z3q_kor_singlex_defconfig

make -j$(nproc) O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN

cp $(pwd)/out/arch/$ARCH/boot/Image $(pwd)/out/Image
cat ${DTS_DIR}/vendor/qcom/*.dtb > $(pwd)/out/dtb.img

sudo cp $(pwd)/out/Image /media/sf_Kernel_Test
sudo cp $(pwd)/out/dtb.img /media/sf_Kernel_Test
