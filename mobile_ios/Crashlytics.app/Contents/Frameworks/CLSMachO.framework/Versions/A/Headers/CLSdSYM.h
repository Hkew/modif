//
//  CLSdSYM.h
//  CLSMachO
//
//  Created by Matt Massicotte on 9/27/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLSMachOBinary;

@interface CLSdSYM : NSObject {
    NSBundle*       _bundle;
    CLSMachOBinary* _binary;
    NSString*       _executablePath;
}

+ (id)dSYMWithURL:(NSURL*)url;

- (id)initWithURL:(NSURL*)url;

@property (nonatomic, copy, readonly) NSString* bundleIdentifier;
@property (nonatomic, copy, readonly) NSURL*    executableURL;
@property (nonatomic, copy, readonly) NSString* executablePath;

- (void)enumerateUUIDs:(void (^)(NSString* uuid, NSString* architecture))block;
- (void)enumerateNormalizedUUIDs:(void (^)(NSString* uuid, NSString* architecture))block;

@end
