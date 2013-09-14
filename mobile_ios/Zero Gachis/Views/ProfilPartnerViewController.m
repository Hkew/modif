//
//  ProfilPartnerViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 03/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "ProfilPartnerViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
#import "CellMagA.h"
#import "CellMagNoA.h"
#import "MapKit/MapKit.h"
#import "CardProduct.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Partenaire.h"
#import "UnderLineLabel.h"
#import "Enseigne.h"
#import "Product.h"
#import <TTTAttributedLabel.h>
#import <AsyncImageView/AsyncImageView.h>

@interface ProfilPartnerViewController ()

@end

@implementation ProfilPartnerViewController
@synthesize magasinSelected,partenaire,arrayProducts,labelRed,labelRefs,labelVille,logo_mag,text_horaire;
@synthesize cellHaut,tableViewProd;


#include "Conf.h"


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)goback
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"%@",partenaire.reduction_moyenne);
    isDataGood = false;
    
    
    // Gestion des horaires - fermeture
    NSArray* aFerm = [partenaire.horaire_fermeture componentsSeparatedByString: @":"];
    
   NSArray* aOuv = [partenaire.horaire_ouverture componentsSeparatedByString: @":"];
    
    NSString* horaire =  [[NSString alloc] initWithFormat:@"%@h%@",[aFerm objectAtIndex: 0],[aFerm objectAtIndex: 1]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH"];
    int hour = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    [dateFormatter setDateFormat:@"mm"];
    int minute = [[dateFormatter stringFromDate:[NSDate date]] intValue];

    //EX : 10h -> situé entre 8h et 19h
    if(hour < [[aFerm objectAtIndex: 0] intValue] && hour > [[aOuv objectAtIndex: 0] intValue]){
         text_horaire.text = [[NSString alloc] initWithFormat:@"Magasin ouvert jusqu'à %@",horaire];
    
    }
    //EX : 8h50 -> 8h45
    else if(hour == [[aOuv objectAtIndex: 0] intValue] && minute > [[aOuv objectAtIndex: 1] intValue]){
        text_horaire.text = [[NSString alloc] initWithFormat:@"Magasin ouvert jusqu'à %@",horaire];
        isClose = false;
        
    
    } //EX : 19h50 -> 19h45
    else if(hour == [[aFerm objectAtIndex: 0] intValue] && minute > [[aFerm objectAtIndex: 1] intValue]){
        text_horaire.text = [[NSString alloc] initWithFormat:@"Magasin ouvert jusqu'à %@",horaire];
        isClose = false;
        
    }else{
        horaire =  [[NSString alloc] initWithFormat:@"%@h%@",[aOuv objectAtIndex: 0],[aOuv objectAtIndex: 1]];
        
        isClose = true;
         text_horaire.text = [[NSString alloc] initWithFormat:@"Magasin fermé jusqu'à %@",horaire];
    }
                        
    if(self.arrayProducts.count == 0){
        isNoProduct = true;
        [self.arrayProducts insertObject:@"1" atIndex:0];
        
    }
    
    
    labelVille.text = partenaire.ville;
    if([partenaire.reduction_moyenne intValue] != 0){
    labelRed.text = [[NSString alloc] initWithFormat:@"-%d%%",[partenaire.reduction_moyenne intValue]];
    }else{
        labelRed.text = [[NSString alloc] initWithFormat:@"%d%%",[partenaire.reduction_moyenne intValue]];
    }
    
    logo_mag.contentMode = UIViewContentModeScaleAspectFit;
    
    [logo_mag setImageURL:[NSURL URLWithString:partenaire.enseigne.logo_mobile]];
    
    
    labelRefs.text = [[NSString alloc] initWithFormat:@"%@ rèf",partenaire.somme_produits];
    
    UIImage *backBtnImage = [UIImage imageNamed:@"bouton_retour"];
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    backBtnImage = [UIImage imageNamed:@"bouton_retour_hover"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateSelected];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 63, 40);
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
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
    navLabel.text=partenaire.ville;
    navLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.navigationItem.titleView = navLabel;
    
    //image
    UIImage *backgroundImage = [UIImage imageNamed:@"fond_bar"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navBar setTintColor:[UIColor whiteColor]];
    
      
    /**************************/

    
    
    NSLog(@"magasin id : %@",partenaire.idPartenaire);
    AppDelegate *Delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    Delegate = [[UIApplication sharedApplication]delegate];
    
    if(!isFixture){
        
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Chargement des produits ...";
    
    hud.delegate = self;
    tableViewProd.contentSize = CGSizeMake(tableViewProd.frame.size.width, 530);
    
   
    }
    
	// Do any additional setup after loading the view.
}


- (void) hideAfterApi
{
    [hud hide:true];
    AppDelegate *Delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    
    NSLog(@"NB Produit : %d",Delegate.arrOfShopProducts.count);
    isDataGood = true;
    [UIView setAnimationsEnabled:NO];
    //[tableViewProd beginUpdates];
    [tableViewProd reloadData];
    //[tableViewProd endUpdates];
    [UIView setAnimationsEnabled:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//if(isFixture)
     
    if(indexPath.row == 0){
        
        return  cellHaut;
    }
    else if(indexPath.row == arrayProducts.count && isClose){
        static NSString *CellIdentifier = @"CardClose";
        
        CardProduct* cell = (CardProduct *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CardClose" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        return cell;
    }
    else if(indexPath.row == arrayProducts.count && isNoProduct){
        static NSString *CellIdentifier = @"CardNoProduct";
        
        CardProduct* cell = (CardProduct *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CardNoProduct" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        return cell;
    }
    else if(indexPath.row == self.arrayProducts.count)
    {
        static NSString *CellIdentifier = @"FooterMag";
    
        CardProduct* cell = (CardProduct *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FooterMag" owner:self options:nil];
            cell = [nib objectAtIndex:0];
           
        }
    
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"CardProduct";
        
         CardProduct* cell = (CardProduct *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CardProduct" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            if(indexPath.row == 1) [cell init:true];
            else [cell init:false];
            
            Product *p = [self.arrayProducts objectAtIndex:indexPath.row-1];
           
            NSString *lib_p;
           
            int filtre;
            
            if([p.marque length] > 12){
                filtre = 20;
            }
            else if([p.marque isEqual:@""]){
                filtre = 40;
            }
            else{
                filtre = 30;
            }
           
            
            if([p.nom length] > filtre){
                lib_p = [[NSString alloc] initWithFormat:@"%@...",[p.nom substringToIndex:filtre-3]];
            }
            else{
                lib_p = p.nom;
            }
            
            if([p.marque isEqual:@""]){
                  cell.labelName.text = [[NSString alloc] initWithFormat:@"%@ %@%@",lib_p,p.poids,p.unite];
            }
            else{
                 cell.labelName.text = [[NSString alloc] initWithFormat:@"%@ %@%@ - %@",lib_p,p.poids,p.unite,p.marque];
            }
            
            cell.labelPrixFinal.text = p.prix_final;
            cell.labelPrixInitial.text = p.prix_initial;
            cell.labelQuantite.text = [[NSString alloc] initWithFormat:@"Qté = %d",[p.quantite_restante integerValue]];
            cell.labelPourcentage.text = [[NSString alloc] initWithFormat:@"-%@%%",p.reduction];
            cell.labelDLC.text = [[NSString alloc] initWithFormat:@"J-%@",p.jours_restants];
            [cell.product_image setImageURL:[NSURL URLWithString:p.photo]];
            
            
        }
        
        return cell;
    
    }
   
    return cellHaut;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row == 0){
        return 200;
    }
    else if(indexPath.row == arrayProducts.count && isClose){
        return 210;
    }
    else if(indexPath.row == arrayProducts.count && isNoProduct){
        return 210;
    }
    else if(indexPath.row == arrayProducts.count){
        return 24;
    }
    
    return 139;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       
    return indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayProducts.count+1;
}


- (void)viewDidUnload {
    [self setCellHaut:nil];
    [self setTableViewProd:nil];
    [self setLabelRefs:nil];
    [self setLabelRed:nil];
    [self setLabelVille:nil];
    [self setLogo_mag:nil];
    [self setText_horaire:nil];
    [super viewDidUnload];
}
- (IBAction)goToMaps:(id)sender {
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([partenaire.latitude floatValue], [partenaire.longitude floatValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:[[NSString alloc] initWithFormat:@"%@ - %@",partenaire.enseigne.nom,partenaire.ville ]];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}
@end
