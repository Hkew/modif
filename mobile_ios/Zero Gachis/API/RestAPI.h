//
//  RestAPI.h
//  Zero Gachis
//
//  Created by Tony Cois on 11/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#import "AppDelegate.h"

#import "Ville.h"

@interface RestAPI : NSObject
{
    RKObjectManager *manager;
    NSMutableData *responseData;
}

-(void)conf;
-(void)getVilles:(NSString*)ville;
-(void)getMagasins:(Ville *)ville;
-(void)getProducts:(NSNumber*)idPartenaire;


@property (nonatomic,strong) AppDelegate *Delegate;

-(void)sendVote:(NSNumber*)vote forMag:(NSNumber*)idMagasin;
- (void)sendMail:(NSString *)mail forMag:(NSNumber *)idMagasin;

@end
