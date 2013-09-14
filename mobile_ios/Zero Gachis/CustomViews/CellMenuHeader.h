//
//  CellMenuHeader.h
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMenuHeader : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *Label;

- (void)setLabelText:(NSString *)labelText;
@end
