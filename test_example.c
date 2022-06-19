#include <dlfcn.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>

typedef void (*entry_fn)(int argc, char** argv);

int main (int argc, char** argv) {
    void* handle = NULL;
    handle = dlopen("./qemu-system-arm.so", RTLD_LAZY);
    if (handle == NULL) {
        fprintf(stderr, "Couldn't open \"./qemu-system-arm.so\" with error: \"%s\"\n", dlerror());
        exit(1);
    }

    entry_fn entry = (entry_fn)dlsym(handle, "main");
    if (entry == NULL)  {
        fprintf(stderr, "Couldn't symbol \"main\" with error: \"%s\"\n", dlerror());
        exit(1);
    }

    // NOTE: you might need to copy pc-bios directory here
    entry(argc, argv);

    return 0;
}