//
//  MenuViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 02/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITableView *menuTable;
}

@property (nonatomic,strong) AppDelegate *Delegate;
@end
