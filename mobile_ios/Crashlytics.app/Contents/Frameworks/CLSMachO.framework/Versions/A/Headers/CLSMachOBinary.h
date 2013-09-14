//
//  CLSMachOBinary.h
//  CLSMachO
//
//  Created by Matt Massicotte on 9/29/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSMachO.h"

@class CLSMachOSlice;

@interface CLSMachOBinary : NSObject {
    NSURL* _url;
    
    struct CLSMachOFile _file;
    NSMutableArray*     _slices;
    NSString*           _instanceIdentifier;
}

+ (id)MachOBinaryWithPath:(NSString*)path;

- (id)initWithURL:(NSURL*)url;

@property (nonatomic, copy,   readonly) NSURL*    URL;
@property (nonatomic, copy,   readonly) NSString* path;
@property (nonatomic, retain, readonly) NSArray*  slices;
@property (nonatomic, copy,   readonly) NSString* instanceIdentifier;

- (void)enumerateUUIDs:(void (^)(NSString* uuid, NSString* architecture))block;
- (void)enumerateNormalizedUUIDs:(void (^)(NSString* uuid, NSString* architecture))block;

- (CLSMachOSlice*)sliceForArchitecture:(NSString*)architecture;

@end
