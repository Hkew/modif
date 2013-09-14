//
//  ProfilPartnerViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 03/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@class TTTAttributedLabel;
@class Partenaire;
@class AsyncImageView;
@class AppDelegate;
@interface ProfilPartnerViewController : UIViewController<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSString* magasinSelected;
    MBProgressHUD *hud;
    bool isDataGood;
    bool isClose;
    bool isNoProduct;

}
- (IBAction)goToMaps:(id)sender;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *text_horaire;

@property (strong, nonatomic) IBOutlet AsyncImageView *logo_mag;

@property (strong, nonatomic) IBOutlet UILabel *labelRefs;
@property (nonatomic,retain) NSString* magasinSelected;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellHaut;
@property (strong, nonatomic) IBOutlet UITableView *tableViewProd;
@property (strong, nonatomic) IBOutlet UILabel *labelVille;

@property (strong, nonatomic) IBOutlet UILabel *labelRed;
@property (nonatomic,retain) NSMutableArray *arrayProducts;

@property (strong, nonatomic) Partenaire *partenaire;
- (void) hideAfterApi;

@end
