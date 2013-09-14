//
//  AppDelegate.h
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "ProfilPartnerViewController.h"
#import "MainViewController.h"
#import "Config.h"
#import "ProfilPartnerViewController.h"
#import "ListingViewController.h"
#import "ProfilNoPartnerViewController.h"

@class RestAPI;


@class ListingViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property (nonatomic,retain) RestAPI *restAPI;
@property (nonatomic,retain) NSString *isIphone5;
@property (nonatomic,retain) NSString *isFirstTime;
@property (strong,nonatomic) JASidePanelController *viewController;
@property (nonatomic,retain) MainViewController *mainViewController;
@property (nonatomic,retain) ListingViewController *listingViewController;
@property (nonatomic,retain) ProfilPartnerViewController *partnerViewController;
@property (nonatomic,retain) ProfilNoPartnerViewController *noPartnerViewController;
@property (nonatomic,retain) UINavigationController *navController;
@property(nonatomic,retain) NSMutableArray   *arrOfCities;
@property(nonatomic,retain) NSMutableArray  *arrOfCitiesString;
@property(nonatomic,retain) NSMutableArray   *arrOfShops;
@property(nonatomic,retain) NSMutableArray   *arrOfProducts;
@property(nonatomic,retain) NSMutableArray   *arrOfShopProducts;
@property (nonatomic,strong) Config *config;

@end
