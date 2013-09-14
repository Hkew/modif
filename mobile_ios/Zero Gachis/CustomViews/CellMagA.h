//
//  CellMagA.h
//  Zero Gachis
//
//  Created by Tony Cois on 02/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsyncImageView;
@interface CellMagA : UITableViewCell
{
    
    
}

@property (strong,nonatomic) IBOutlet UILabel *labelKm;
@property (strong,nonatomic) IBOutlet UILabel *labelRed;
@property (strong,nonatomic) IBOutlet UILabel *labelRef;
@property (strong, nonatomic) IBOutlet AsyncImageView *logo_mag;
@property (strong,nonatomic) IBOutlet UILabel *labelVille;
@property (strong,nonatomic) IBOutlet UILabel *labelEnseigne;

@end
