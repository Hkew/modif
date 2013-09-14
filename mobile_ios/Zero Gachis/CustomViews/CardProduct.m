//
//  CardProduct.m
//  Zero Gachis
//
//  Created by Tony Cois on 05/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "CardProduct.h"
#import "UnderLineLabel.h"
@implementation CardProduct

@synthesize labelDLC,labelName,labelPourcentage,labelPrixFinal,labelPrixInitial,labelQuantite,imagebg;

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
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)init:(BOOL)first{
    if(first){
        [imagebg setImage:[UIImage imageNamed:@"card_first_product"]];
        
    }
        [labelPrixInitial setShouldStrikeOut:YES];
    [labelPrixInitial setUnderLineOffset:-5];
    
    
}



@end
