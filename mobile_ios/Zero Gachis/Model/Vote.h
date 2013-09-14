//
//  Vote.h
//  Zero Gachis
//
//  Created by Tony Cois on 24/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vote : NSObject

@property (nonatomic, retain) NSString * client;
@property (nonatomic, retain) NSNumber * shop_id;
@property (nonatomic, retain) NSString * udid;
@property (nonatomic, retain) NSNumber * vote;
@property (nonatomic, retain) NSNumber * votes_contre;
@property (nonatomic, retain) NSNumber * votes_pour;
@end
