//
//  GuideController.h
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@interface GuideController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewGuide;

@property (nonatomic,strong) AppDelegate *Delegate;
@end
