//
//  CLSMachO.h
//  CLSMachO
//
//  Created by Matt Massicotte on 9/27/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#pragma once

#include "CLSMachONamespace.h"

#include <mach-o/arch.h>
#include <mach-o/loader.h>
#include <sys/types.h>

#include <CoreFoundation/CoreFoundation.h>

struct CLSMachOFile {
    int    fd;
    size_t mappedSize;
    void*  mappedFile;
};
typedef struct CLSMachOFile* CLSMachOFileRef;

struct CLSMachOSlice {
    const void*   startAddress;
    const void*   header;
    cpu_type_t    cputype;
    cpu_subtype_t cpusubtype;
};
typedef struct CLSMachOSlice* CLSMachOSliceRef;

typedef struct {
    uint32_t major;
    uint32_t minor;
    uint32_t bugfix;
} CLSMachOVersion;

typedef void(^CLSMachOSliceIterator)(CLSMachOSliceRef slice);
typedef void(^CLSMachOLoadCommandIterator)(uint32_t type, uint32_t size, const struct load_command* cmd);

__BEGIN_DECLS

bool CLSMachONamespace(MachOFileInitWithPath)(CLSMachOFileRef file, const char* path);
void CLSMachONamespace(MachOFileDestroy)(CLSMachOFileRef file);
void CLSMachONamespace(MachOFileEnumerateSlices)(CLSMachOFileRef file, CLSMachOSliceIterator block);

void CLSMachONamespace(MachOEnumerateSlicesAtAddress)(void* executableData, CLSMachOSliceIterator block);
void CLSMachONamespace(MachOSliceEnumerateLoadCommands)(CLSMachOSliceRef slice, CLSMachOLoadCommandIterator block);
struct CLSMachOSlice CLSMachONamespace(MachOSliceGetCurrent)(void);
struct CLSMachOSlice CLSMachONamespace(MachOSliceWithHeader)(void* machHeader);

const char* CLSMachONamespace(MachOSliceGetExecutablePath)(CLSMachOSliceRef slice);
const char* CLSMachONamespace(MachOSliceGetArchitectureName)(CLSMachOSliceRef slice);
bool        CLSMachONamespace(MachOSliceIs64Bit)(CLSMachOSliceRef slice);
void        CLSMachONamespace(MachOSliceGetUnwindInformation)(CLSMachOSliceRef slice, const void** ehFrame, const void** unwindInfo);

// load-command-specific calls for convenience

// returns a pointer to the 16-byte UUID
uint8_t const* CLSMachONamespace(MachOGetUUID)(const struct load_command* cmd);
const char*    CLSMachONamespace(MachOGetDylibPath)(const struct load_command* cmd);

// return true if the header indicates the binary is encrypted
bool CLSMachONamespace(MachOGetEncrypted)(const struct load_command* cmd);

// SDK minimums
CLSMachOVersion CLSMachONamespace(MachOGetMinimumOSVersion)(const struct load_command* cmd);
CLSMachOVersion CLSMachONamespace(MachOGetLinkedSDKVersion)(const struct load_command* cmd);


// linker sections

// Helpers
#ifdef __OBJC__
NSString* CLSMachONamespace(MachONormalizeUUID)(CFUUIDBytes* uuidBytes);
#endif
__END_DECLS
