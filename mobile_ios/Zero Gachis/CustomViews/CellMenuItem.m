//
//  CellMenuItem.m
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "CellMenuItem.h"

@implementation CellMenuItem

@synthesize label,imageRight,imageLeft,backgroundImageHold;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
 //   [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfos:(int)mode{
    switch (mode) {
        case 1:
            [label setText:@"RECHERCHE"];
            imageLeft.image=[UIImage imageNamed:@"ic_search"];
            imageRight.image=[UIImage imageNamed:@"ic_arrow"];
            break;
        
        case 3:
            [label setText:@"GUIDE"];
            imageLeft.image=[UIImage imageNamed:@"ic_guide"];
            imageRight.image=[UIImage imageNamed:@"ic_arrow"];
            break;
            
        case 4:
            [label setText:@"ZÉRO-GÂCHIS"];
            imageLeft.image=[UIImage imageNamed:@"ic_zg"];
            imageRight.image=[UIImage imageNamed:@"ic_arrow"];
            break;
        
        case 6:
            [label setText:@"TWITTER"];
            imageLeft.image=[UIImage imageNamed:@"ic_twitter"];
            imageRight.image=[UIImage imageNamed:@"ic_world"];
            break;
        
        case 7:
            [label setText:@"FACEBOOK"];
            imageLeft.image=[UIImage imageNamed:@"ic_fb"];
            imageRight.image=[UIImage imageNamed:@"ic_world"];
            break;
        
        case 8:
            [label setText:@"NOTEZ L'APP"];
            imageLeft.image=[UIImage imageNamed:@"ic_star"];
            imageRight.image=[UIImage imageNamed:@"ic_world"];
            break;
            
        default:
            break;
    }

    
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        NSLog(@"if passage higl");
        self.backgroundImageHold.hidden = false;
        
    } else {
        
        NSLog(@"if passage higl");
        self.backgroundImageHold.hidden = true;
        
        
    }
}
@end