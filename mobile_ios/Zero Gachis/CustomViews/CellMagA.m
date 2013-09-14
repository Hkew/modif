//
//  CellMagA.m
//  Zero Gachis
//
//  Created by Tony Cois on 02/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "CellMagA.h"

@implementation CellMagA

@synthesize labelEnseigne,labelKm,labelRed,labelRef,labelVille;

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

@end
