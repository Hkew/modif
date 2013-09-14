//
//  CardProduct.h
//  Zero Gachis
//
//  Created by Tony Cois on 05/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UnderLineLabel;
@class AsyncImageView;

@interface CardProduct : UITableViewCell
@property (strong, nonatomic) IBOutlet AsyncImageView *product_image;

@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelPourcentage;
@property (strong, nonatomic) IBOutlet UnderLineLabel *labelPrixInitial;
@property (strong, nonatomic) IBOutlet UILabel *labelPrixFinal;
@property (strong, nonatomic) IBOutlet UIImageView *imagebg;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantite;
@property (strong, nonatomic) IBOutlet UILabel *labelDLC;

- (void)init:(BOOL)first;
@end
