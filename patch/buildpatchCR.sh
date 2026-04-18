#!/bin/bash

BUILD_SCRIPT=$1

if [ -f "$BUILD_SCRIPT" ]; then
    echo "Patching $BUILD_SCRIPT untuk crDroid surya (Droidspaces inline)..."

    # Mencari baris 'make ... $DEFCONFIG' dan menyisipkan droidspaces.config
    # Kita menggunakan regex yang mendukung opsi variasi spasi atau argumen lain
    sed -i 's/\(make[[:space:]].*\$DEFCONFIG\)/\1 droidspaces.config droidspaces-additional.config/' "$BUILD_SCRIPT"

    echo "Patching selesai. Perintah make sekarang menyertakan Droidspaces configs."
else
    echo "Error: File $BUILD_SCRIPT tidak ditemukan!"
    exit 1
fi
