#!/bin/bash

if [[ "$QEMU_PATH" = "" ]]; then
    echo "WARNING: QEMU_PATH is not set. Trying to execute in ${PWD}"
    export QEMU_PATH=$PWD
fi

tempFile1=$(mktemp)
tempFile2=$(mktemp)

echo "Configure"
cd $QEMU_PATH
./configure $@ --extra-cflags=-fPIC
cp build/build.ninja $tempFile1
# remove PIE as it is not compatible with PIC
sed -i 's/-fPIE//' $tempFile1
marker=0
# add to linker option -fPIC -shared in order to create shared binary (.so/.dll)
while IFS= read -r line
do
    if [[ $marker = 1 ]]; then
        echo "$line -fPIC -shared" >> $tempFile2
    else
        echo "$line" >> $tempFile2
    fi
    marker=0
    if [[ "$line" == *"build qemu-system"*"cpp_LINKER_RSP"* ]]; then
        marker=1
    fi
done < $tempFile1

cp $tempFile2 build/build.ninja 
rm $tempFile1
rm $tempFile2
