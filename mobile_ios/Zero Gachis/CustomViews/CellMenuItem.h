//
//  CellMenuItem.h
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMenuItem : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageRight;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *imageLeft;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageHold;

- (void)setInfos:(int)mode;
@end
