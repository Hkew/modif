//
//  PLGURLDownloadPromise.h
//  MacApp
//
//  Created by Matt Massicotte on 12/31/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import <Pledge/Pledge.h>

@interface PLGURLDownloadPromise : PLGPromise {
    NSURLRequest*  _request;
    NSURLDownload* _download;
    NSString*      _path;
    NSString*      _fileName;
}

+ (instancetype)URLDownloadPromiseWithURLRequest:(NSURLRequest*)request toPath:(NSString*)path;

- (void)addResolutionHandler:(void (^)(NSURLRequest* request, NSString* path, NSString* fileName))handler;
- (void)addRejectionHandler:(void (^)(NSURLRequest* request, NSError* error))handler;

@property (nonatomic, copy, readonly) NSString* path;

@end
