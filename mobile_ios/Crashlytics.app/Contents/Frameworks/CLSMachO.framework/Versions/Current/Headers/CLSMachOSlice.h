//
//  CLSMachOSlice.h
//  CLSMachO
//
//  Created by Matt Massicotte on 9/29/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSMachO.h"

@interface CLSMachOSlice : NSObject {
    struct CLSMachOSlice _slice;
    
    NSString* _uuidString;
    NSArray*  _linkedDylibs;
    CLSMachOVersion _minimumOSVersion;
    CLSMachOVersion _linkedSDKVersion;
}

+ (id)runningSlice;

- (id)initWithSlice:(CLSMachOSliceRef)sliceRef;

@property (nonatomic, copy,   readonly) NSString* uuid;
@property (nonatomic, copy,   readonly) NSString* architectureName;
@property (nonatomic, retain, readonly) NSArray*  linkedDylibs;
@property (nonatomic, assign, readonly) CLSMachOVersion minimumOSVersion;
@property (nonatomic, assign, readonly) CLSMachOVersion linkedSDKVersion;

@property (nonatomic, assign, readonly) const void* ehFrameData;
@property (nonatomic, assign, readonly) const void* unwindInfoData;

@end
