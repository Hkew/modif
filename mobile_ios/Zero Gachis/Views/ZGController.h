//
//  ZGController.h
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@interface ZGController : UIViewController<UIScrollViewDelegate>



@property (nonatomic,strong) AppDelegate *Delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableViewZG;

@end
