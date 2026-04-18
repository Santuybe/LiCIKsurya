#!/bin/bash

BUILD_SCRIPT=$1

if [ -f "$BUILD_SCRIPT" ]; then
    echo "Patching $BUILD_SCRIPT untuk Droidspaces..."

    # 1. Sisipkan perintah merge_config.sh untuk droidspaces.config utama
    # Mencari baris 'make ... defconfig' dan menambahkan perintah di bawahnya
    sed -i '/make.*defconfig/a \
    echo "Merging Droidspaces Config..." \
    ./kernel_workspace/scripts/kconfig/merge_config.sh -O out -m out/.config kernel_workspace/arch/arm64/configs/droidspaces.config' "$BUILD_SCRIPT"

    # 2. Sisipkan perintah untuk droidspaces-additional.config jika ada
    sed -i '/droidspaces.config/a \
    if [ -f "kernel_workspace/arch/arm64/configs/droidspaces-additional.config" ]; then \
        echo "Merging Additional Droidspaces Config..." \
        ./kernel_workspace/scripts/kconfig/merge_config.sh -O out -m out/.config kernel_workspace/arch/arm64/configs/droidspaces-additional.config; \
    fi' "$BUILD_SCRIPT"

    # 3. Sisipkan 'make olddefconfig' untuk memastikan integritas config
    sed -i '/droidspaces-additional.config/a \
    make O=out ARCH=arm64 olddefconfig' "$BUILD_SCRIPT"

    echo "Patching selesai."
else
    echo "File $BUILD_SCRIPT tidak ditemukan!"
    exit 1
fi
