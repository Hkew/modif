//
//  GuideCell.h
//  Zero Gachis
//
//  Created by Tony Cois on 25/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logo_guide;

@property (strong, nonatomic) IBOutlet UITextView *text_second_guide;

@property (strong, nonatomic) IBOutlet UITextView *textview_guide;
@property (strong, nonatomic) IBOutlet UIImageView *text_guide;
@end
