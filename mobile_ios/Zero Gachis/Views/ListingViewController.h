//
//  ListingViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 29/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <MBProgressHUD/MBProgressHUD.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "AppDelegate.h"
#import "Partenaire.h"
#import "Ville.h"
#import "Vote.h"
#import "Magasin.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"

@interface ListingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    NSString *ville;
    IBOutlet UITableView *tableViewListing;
    MBProgressHUD *hud;
    
    IBOutlet TTTAttributedLabel *villeLabel;
    IBOutlet UITableView *tableNoPartners;
    IBOutlet UIScrollView *scrollView;
    NSInteger modeView;
    Partenaire *partenaire;
    int positionLimit;
    Boolean isEndPartenaire;
    IBOutlet UIButton *btnNoPartners;
    IBOutlet UIButton *btnPartners;
    IBOutlet UIImageView *arrowCity;
    IBOutlet UIImageView *barCity;
}
@property (strong, nonatomic) IBOutlet UITableViewCell *cellHaut;


@property (strong, nonatomic) IBOutlet NSString *ville;
@property (strong,nonatomic) Ville *villeObj;
@property (strong, nonatomic) NSString *latitude;
@property (strong,nonatomic) NSNumber *isMagasin;
@property (strong,nonatomic) NSString *longitude;

@property (nonatomic,retain) NSMutableArray *arrayMagasins;

@property (nonatomic,retain) NSMutableArray *arrayProducts;
@property (nonatomic,strong) AppDelegate *Delegate;

-(void)setVote:(Vote *)vote forMag:(Magasin *)mag;

-(void)setTabProducts:(NSArray *)tabProducts;
- (void) getError;

@end
