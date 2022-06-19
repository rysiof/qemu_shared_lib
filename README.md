# Build QEMU as shared library (.so)

If your goal is to export qemu to shared library (.so) this script is what you are looking for!

```bash
git clone https://github.com/qemu/qemu.git
export QEMU_PATH=$PWD/qemu

git clone https://github.com/rysiof/qemu_shared_lib.git
sh qemu_shared_lib/build_as_shared.sh [OPTIONS FOR CONFIGURE]
# example: sh qemu_shared_lib/build_as_shared.sh --target-list=arm-softmmu,aarch64-softmmu

cd $QEMU_PATH
make -j $(nproc)
```

# Last Update
- Tested on qemu commit ``a28498b1f9591e12dcbfdf06dc8f54e15926760e`` (latest on 06/16/2022)
- Tested using configuration ``--target-list=arm-softmmu,aarch64-softmmu``
- Tested on Fedora 36 using ``test_example.c``