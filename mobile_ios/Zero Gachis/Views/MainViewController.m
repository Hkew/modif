//
//  MainViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Config.h"
#import "ListingViewController.h"
#import "JASidePanelController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <CoreLocation/CoreLocation.h>
#import "RestAPI.h"
#import "Ville.h"


@interface MainViewController ()
// start Modif
- (void)showAnimateGeolocStart;
// end Modif
@end

@implementation MainViewController;

@synthesize Delegate;
@synthesize autocompleteTableView;
@synthesize isloading;
@synthesize currentLongitude,currentLatitude;
@synthesize pastUrls,latitudes,longitudes,villes,autocompleteUrls,codepostaux,arrayVilles,arrayMagasins;


#include "Conf.h"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)goPanel
{
    if(!isChargement){
        if(textGeoloc.isFirstResponder){
        
            [textGeoloc resignFirstResponder];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            // The kKeyboardAnimationDuration I am using is 0.3
            [UIView setAnimationDuration:0.3];
        
            self.autocompleteTableView.hidden = true;
            btnMag.hidden = false;
            labelHome.hidden = false;
            textGeoloc.text = @"";
            if([Delegate.isIphone5 intValue] == 1){
                [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 310, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
            }else{
                [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 270, viewGeoloc.frame.size.width,viewGeoloc.frame.   size.height)];
            
            }
            [UIView commitAnimations];
        
        }
        [Delegate.viewController showLeftPanelAnimated:true];
    }
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    isChargement = false;
    
    /* Configuraiton de la view */
    Delegate = [[UIApplication sharedApplication]delegate];
    
    if([Delegate.isFirstTime boolValue]){
        NSLog(@"Première fois");
    }else{
        NSLog(@"Deuxième fois");
    }
    
    /* Configuration de la tableview autocomplete */
    
    if([Delegate.isIphone5 intValue] == 1){
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, viewGeoloc.frame.origin.y-40, viewGeoloc.frame.size.width, viewGeoloc.frame.size.height)];
        [labelHome setFrame:CGRectMake(labelHome.frame.origin.x, labelHome.frame.origin.y+30, labelHome.frame.size.width, labelHome.frame.size.height)];
        
    }
    else{
        
    }
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(19, 114, 226, 93) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = true;
    [self.view addSubview:autocompleteTableView];
    
    
    
    /**** Conf de la barre ****/
    
        UINavigationBar *navBar = [[self navigationController] navigationBar];
        [navBar setTranslucent:true];
    
        //Label titre
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 50)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.textColor = [UIColor whiteColor];
        navLabel.shadowColor = [UIColor colorWithRed:112.0/255.0 green:168.0/255.0 blue:180.0/255.0 alpha:1];
        navLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"size:22];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text=@"Recherche";
        self.navigationItem.titleView = navLabel;
    
        //image
        UIImage *backgroundImage = [UIImage imageNamed:@"fond_bar"];
        [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        [navBar setTintColor:[UIColor whiteColor]];
    
        //Bouton menu
        UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backBtnImage = [UIImage imageNamed:@"btn-menu"]  ;
        [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goPanel) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = CGRectMake(0,0, 44, 32);
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
        self.navigationItem.leftBarButtonItem = cancelButton;
 
    /**************************/
    
    
    
    /***** Gestion de l'input *********/
    btnMag.hidden = false;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, textGeoloc.bounds.size.height)];
    textGeoloc.leftView = leftView;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 47, textGeoloc.bounds.size.height)];
    textGeoloc.rightView = rightView;
    
    textGeoloc.rightViewMode = UITextFieldViewModeAlways;
    textGeoloc.leftViewMode = UITextFieldViewModeAlways;
    
    
    /**** Gestion du clavier **********/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    
    [self.view addGestureRecognizer:leftRecognizer];
}


- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{

}


- (void)keyboardWillShow:(NSNotification *)n
{
    [Delegate.viewController setAllowLeftSwipe:false];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:0.3];
    if(textGeoloc.isFirstResponder){
        
        
        labelHome.hidden = true;
        btnMag.hidden = true;
        
        [imgEndKeyboard setFrame:CGRectMake(imgEndKeyboard.frame.origin.x,-57,imgEndKeyboard.frame.size.width,imgEndKeyboard.frame.size.height)];
        
        
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x,50,viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
        
        /*
        if([Delegate.isIphone5 intValue] == 1){
            [imgEndKeyboard setFrame:CGRectMake(imgEndKeyboard.frame.origin.x,-27,imgEndKeyboard.frame.size.width,imgEndKeyboard.frame.size.height)];
            
            
            [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x,23,viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
        }
        else{
            [imgEndKeyboard setFrame:CGRectMake(imgEndKeyboard.frame.origin.x,-27,imgEndKeyboard.frame.size.width,imgEndKeyboard.frame.size.height)];
            [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x,23,viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
        }
        */
    }
    [UIView commitAnimations];
    
}

- (void)keyboardWillHide:(NSNotification *)n
{
    [Delegate.viewController setAllowLeftSwipe:true];
    
    
}

- (void)showAnimateGeolocEnd
{
    [textGeoloc resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    self.autocompleteTableView.hidden = true;
    btnMag.hidden = false;
    labelHome.hidden = false;
    textGeoloc.text = @"";
    
    if([Delegate.isIphone5 intValue] == 1){
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 310, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
    }else{
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 270, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
    }
        
        [UIView commitAnimations];
}
// MODIF
- (void)showAnimateGeolocStart
{
    [textGeoloc resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    self.autocompleteTableView.hidden = true;
    btnMag.hidden = false;
    labelHome.hidden = false;
    textGeoloc.text = @"";
    
    if([Delegate.isIphone5 intValue] == 1){
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 310, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
    }else{
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 270, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
    }
    
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == textGeoloc){
        if(textField.text.length == 0){
            [self showAnimateGeolocEnd];
            
        }else{
            [self goSearch:nil];
            
        }
    }
    return YES;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    return CGRectInset( bounds , 10 , 10 );
}

- (void)viewDidDisappear:(BOOL)animated{
    viewGeoloc.hidden = false;
    btnMag.hidden = false;
    imgGeolocInfo.hidden = false;
    titleMag.hidden = false;
    imgEndKeyboard.hidden = true;
    btnSearch.hidden = true;
    [arrayVilles removeAllObjects];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNavBar:nil];
    [self setViewMain:nil];
    btnMag = nil;
    titleMag = nil;
    imgGeolocInfo = nil;
    viewGeoloc = nil;
    textGeoloc = nil;
    imgEndKeyboard = nil;
    btnSearch = nil;
    labelHome = nil;
    [super viewDidUnload];
}

- (IBAction)showGeolocForm:(id)sender {
    if(viewGeoloc.hidden == true){
        
        
        tabSearch = [[NSMutableArray alloc] init];
        [UIView beginAnimations:@"button_in" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(showInfoGeoloc)];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
        btnMag.hidden = false;
        titleMag.hidden = true;
        
        if([Delegate.isIphone5 intValue] == 0){
            [btnMag setFrame:CGRectMake(btnMag.frame.origin.x, 80, btnMag.frame.size.width, btnMag.frame.size.height)];
        }else{
            [btnMag setFrame:CGRectMake(btnMag.frame.origin.x, 140, btnMag.frame.size.width, btnMag.frame.size.height)];
        }
        [UIView commitAnimations];
        
    }
    
}



# pragma TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
        
    }
    
    if(self.isloading){
        
    }else{
        
        if(arrayVilles.count == 0){
            cell.textLabel.text = @"Aucun résultat";
        }
        else{
            Ville *v = [arrayVilles objectAtIndex:indexPath.row];
            cell.textLabel.text = v.nom;
        }
      
        cell.textLabel.font = [UIFont fontWithName:@"System" size:20];
    }
    
    return  cell;
    
    
}



- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if(self.arrayVilles.count > 0){
        currentCity = [self.arrayVilles objectAtIndex:indexPath.row];
        
        if(currentCity != nil){
           [self initListingAndGo];
        }
    }

    return indexPath;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.isloading || self.arrayVilles.count == 0){
        return 1;
    }else{
        return [self.arrayVilles count];
    }
}

-(void) networkError:(NSError*)error {
    
    
    UIAlertView *networkError = [[UIAlertView alloc]initWithTitle:@"Erreur Réseau" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Recommencer" otherButtonTitles:@"Annuler", nil];
    [networkError show];
    
}



- (IBAction)goSearch:(id)sender {
    
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    
    
    if(self.arrayVilles.count > 0){
         currentCity = [self.arrayVilles objectAtIndex:indexPath.row];
    
        if(currentCity != nil){
            [self showAnimateGeolocEnd];
              [self initListingAndGo];
        }
    }
}



- (void) showInfoGeoloc{
    viewGeoloc.hidden = false;
    
    
}


/* // original
- (IBAction)geolocUser:(id)sender {
   
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Modif show "loading"
    
    
    // Modif NEW QUEUE ?
    
    [locationManager startUpdatingLocation];
    
    
    // perform geocode
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           // do stuff with placemarks on the main thread
                           
                           if (placemarks.count == 0) {
                               // Modif KILL LOADING VIEW 
                               
                               UIAlertView *alert = [[UIAlertView alloc] init];
                               alert.title = @"Nous n'avons pas trouvé votre ville. Essayez la recherche manuelle.";
                               [alert addButtonWithTitle:@"Ok"];
                               [alert show];
                           }
                           
                           
                           if(placemarks && placemarks.count > 0)
                           {
                               //do something
                               CLPlacemark *topResult = [placemarks objectAtIndex:0];
                               NSString *addressTxt = [NSString stringWithFormat:@"%@",
                                                       [topResult locality]];
                               
                               
                               currentCity = [[Ville alloc] init];
                               currentCity.nom = addressTxt;
                               currentCity.latitude = [[NSNumber alloc] initWithFloat:topResult.location.coordinate.latitude];
                               currentCity.longitude = [[NSNumber alloc] initWithFloat:topResult.location.coordinate.longitude];
                               currentCity.pays = topResult.country;
                               currentCity.code = topResult.postalCode;
                               
                               [self showAnimateGeolocEnd];
                             
                               [self initListingAndGo];
                               
                                                        
                               
                           }
                       }); // end main Queue
                   }];
        
         
}   */ // orignal

//****** Stat Modif  ***///

- (IBAction)geolocUser:(id)sender {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // show "loading"
    [self showAnimateGeolocStart];
    
    // NEW QUEUE ?
    dispatch_queue_t locationQueue = dispatch_queue_create("location queue", NULL);
    dispatch_async(locationQueue, ^{
    
    [locationManager startUpdatingLocation];
    
    
    // perform geocode
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           // do stuff with placemarks on the main thread
                           
                           if (placemarks.count == 0) {
                               // KILL LOADING VIEW
                               
                               UIAlertView *alert = [[UIAlertView alloc] init];
                               alert.title = @"Nous n'avons pas trouvé votre ville. Essayez la recherche manuelle.";
                               [alert addButtonWithTitle:@"Ok"];
                               [alert show];
                           }
                           
                           
                           if(placemarks && placemarks.count > 0)
                           {
                               //do something
                               CLPlacemark *topResult = [placemarks objectAtIndex:0];
                               NSString *addressTxt = [NSString stringWithFormat:@"%@",
                                                       [topResult locality]];
                               
                               
                               currentCity = [[Ville alloc] init];
                               currentCity.nom = addressTxt;
                               currentCity.latitude = [[NSNumber alloc] initWithFloat:topResult.location.coordinate.latitude];
                               currentCity.longitude = [[NSNumber alloc] initWithFloat:topResult.location.coordinate.longitude];
                               currentCity.pays = topResult.country;
                               currentCity.code = topResult.postalCode;
                               
                              // [self showAnimateGeolocEnd];
                               
                               [self initListingAndGo];
                               
                               
                               
                           }
                       }); // end main Queue
                       
                       
                   }];
     }); // end location Queue
    
}

                   
                   
                   
// end modif

                   
                   
                   

- (void)initListingAndGo
{
    //Configuration du HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Chargement ...";
    isChargement = true;
    [Delegate.viewController setAllowLeftSwipe:false];
    
    hud.delegate = self;
    
   // [textGeoloc resignFirstResponder];
    
    [self showAnimateGeolocEnd];
    btnSearch.hidden = true;
    [textGeoloc setText:currentCity.nom];
    
    //On fait la requête
    [Delegate.restAPI getMagasins:currentCity];
    
   
}



- (IBAction)performSearch:(id)sender {
    
    
    if(textGeoloc.text.length > 2){
        autocompleteTableView.hidden = false;
        
        [Delegate.restAPI getVilles:textGeoloc.text];
       
        // [Delegate.api getListOfCity:textGeoloc.text];
       
        
        
    }else{
        
        autocompleteTableView.hidden = YES;
        
    }
    
}


-(void)setTabVilles:(NSArray *)tabVilles{
    
    self.arrayVilles = [tabVilles mutableCopy];
    
    
    [self refreshListing];
}


-(void)setTabMagasins:(NSArray *)tabMagasins{
    
    
    self.arrayMagasins = [tabMagasins mutableCopy];
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    
    [hud hide:true];
    
    
    [textGeoloc resignFirstResponder];
    
    btnSearch.hidden = true;
    
    self.autocompleteTableView.hidden = true;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ListingStoryboard" bundle:nil];
    ListingViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ListingViewController"];
    vc.villeObj = currentCity;
    
    vc.arrayMagasins = self.arrayMagasins;
    Delegate.listingViewController = vc;
    
    textGeoloc.text = @"";
    if([Delegate.isIphone5 intValue] == 1){
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 310, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
        
    }else{
        [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 270, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
        
    }
    isChargement = false;
    [Delegate.viewController setAllowLeftSwipe:true];
    

    [self.navigationController pushViewController:vc animated:YES];

    
}

-(void)refreshListing{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    NSMutableArray *indexPathsToAdd    = [[NSMutableArray alloc] init];
    
    NSInteger totalRows = [autocompleteTableView numberOfRowsInSection:0];
    
    //On va faire un tableau des cellules à supprimer
    NSMutableArray* indexPathsToDelete = [[NSMutableArray alloc] init];
   
    for (int j=0; j<totalRows; j++) {
        
        [indexPathsToDelete addObject: [NSIndexPath indexPathForRow:j inSection:0]];
        
    }
    
    int count = 0;
    
    for (int i=0;i<self.arrayVilles.count;i++){
        [indexPathsToAdd addObject: [NSIndexPath indexPathForRow:count inSection:0]];
        count++;
    }
    
    if(self.arrayVilles.count == 0){
        [indexPathsToAdd addObject: [NSIndexPath indexPathForRow:0 inSection:0]];
    }
         
    btnSearch.hidden = false;
    btnSearch.enabled = true;
   
    [self.autocompleteTableView beginUpdates];
    [self.autocompleteTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    [self.autocompleteTableView insertRowsAtIndexPaths:indexPathsToAdd withRowAnimation:UITableViewRowAnimationTop];
    [self.autocompleteTableView endUpdates];
    [self.autocompleteTableView flashScrollIndicators];
    
   
    
}

- (void) getError
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    [hud hide:true];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de réseau" message:@"Un problème est intervenu avec notre serveur. Veuillez nous excuser." delegate:self cancelButtonTitle:@"Fermer" otherButtonTitles:nil];
    
    [alert show];
    
}

@end