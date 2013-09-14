//
//  Config.h
//  Zero Gachis
//
//  Created by Tony Cois on 03/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Config : NSManagedObject

@property (nonatomic, retain) NSNumber * isFirst;
@property (nonatomic, retain) NSNumber * isIphone5;

@end
