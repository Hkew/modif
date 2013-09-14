//
//  ProfilNoPartnerViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 03/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Magasin.h"
#import <MBProgressHUD/MBProgressHUD.h>
@class AsyncImageView;
@class AppDelegate;
@class Vote;

@interface ProfilNoPartnerViewController : UIViewController<MBProgressHUDDelegate>
{
    
    IBOutlet UIImageView *questionA;
    IBOutlet UIButton *btnYesA;
    IBOutlet UIButton *btnNoA;
    
    MBProgressHUD *hud;
    
    
    IBOutlet UIImageView *questionB;
    IBOutlet UIButton *btnYesB;
    IBOutlet UIButton *btnNoB;
    
    IBOutlet UIImageView *questionC;
    NSTimer *timer;
    IBOutlet UIButton *btnNoC;
    IBOutlet UIButton *btnYesC;
    IBOutlet UITextField *textEmail;
    IBOutlet UIView *viewQ3;
}
@property (strong, nonatomic) IBOutlet UIView *view_content;
@property (strong, nonatomic) IBOutlet UILabel *labelOui;
@property (strong, nonatomic) IBOutlet UILabel *labelNon;
@property (strong, nonatomic) IBOutlet AsyncImageView *logo_mag;
@property (strong, nonatomic) IBOutlet UITextView *labelVote2;
@property (strong, nonatomic) IBOutlet UITextView *labelMail;
@property (strong, nonatomic) IBOutlet UITextView *labelMerci;
@property (strong, nonatomic) IBOutlet UIButton *boutonOk;
@property (strong, nonatomic) IBOutlet UIButton *boutonNon;

@property (strong, nonatomic) IBOutlet UIView *viewContentAll;
@property (strong, nonatomic) IBOutlet UIButton *boutonOui;
@property (strong, nonatomic) IBOutlet UITextView *labelVote1;
- (IBAction)sendEmail:(id)sender;
@property (nonatomic,strong) AppDelegate *Delegate;

- (void)setVote:(Vote*)vote;
- (void) getError;
- (IBAction)voteNon:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *labelVille;
- (IBAction)voteOui:(id)sender;
@property (strong,nonatomic) Magasin *magasin;
- (IBAction)goToQ3No:(id)sender;
-(void)setMerci;
- (IBAction)goToQ2No:(id)sender;
- (IBAction)goToThank:(id)sender;
- (IBAction)goToQ3:(id)sender;
- (IBAction)goToQ2:(id)sender;
@end
