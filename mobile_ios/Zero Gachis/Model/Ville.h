//
//  Ville.h
//  Zero Gachis
//
//  Created by Tony Cois on 11/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ville : NSObject

@property (nonatomic, retain) NSString * agglomeration;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * departement;
@property (nonatomic, retain) NSNumber * idVille;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSString * pays;
@property (nonatomic, retain) NSNumber * precision;
@property (nonatomic, retain) NSString * region;

@end
