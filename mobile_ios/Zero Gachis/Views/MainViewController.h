//
//  MainViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>

#import <CoreLocation/CLLocationManagerDelegate.h>

@class AppDelegate;
@class Config;

#import "Ville.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MainViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet UIButton *btnMag;
    IBOutlet UILabel *labelHome;
    IBOutlet UIButton *titleMag;
    UIImageView *endTableViewSearch;
    NSNumber *currentLatitude;
    NSNumber *currentLongitude;
    NSMutableArray *tabSearch;
    MBProgressHUD *hud;
    IBOutlet UIImageView *imgGeolocInfo;
    
    IBOutlet UIView *viewGeoloc;
    IBOutlet UITextField *textGeoloc;
    IBOutlet UIImageView *imgEndKeyboard;
    UITableView *autocompleteTableView;
    IBOutlet UIButton *btnSearch;
    
    NSMutableArray *pastUrls;
    NSMutableArray *villes;
    NSMutableArray *autocompleteUrls;
    NSString *isIphone5;
    NSMutableArray *latitudes;
    NSMutableArray *longitudes;
    Ville *currentCity;
    NSMutableArray *codepostaux;
    bool isChargement;
    CGPoint startPosition;
    
}
- (IBAction)performSearch:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIView *viewMain;
- (IBAction)geolocUser:(id)sender;
@property (nonatomic, assign) Boolean isloading;

@property (nonatomic, retain) NSMutableArray *pastUrls;
@property (nonatomic, retain) NSMutableArray *latitudes;
@property (nonatomic, retain) NSMutableArray *villes;
@property (nonatomic, retain) NSMutableArray *longitudes;
@property (nonatomic, retain) NSMutableArray *codepostaux;
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (nonatomic,retain) UITableView *autocompleteTableView;
@property (nonatomic,retain) NSNumber *currentLatitude;
@property (nonatomic,retain) NSNumber *currentLongitude;
@property (nonatomic,retain) NSMutableArray *arrayVilles;
@property (nonatomic,retain) NSMutableArray *arrayMagasins;


- (void) setTabVilles:(NSArray *)tabVilles;
- (void) setTabMagasins:(NSArray *)tabMagasins;

- (void) getError;
- (IBAction)goSearch:(id)sender;

- (void) networkError:(NSError*)error;
@property (nonatomic,strong) AppDelegate *Delegate;

@end
