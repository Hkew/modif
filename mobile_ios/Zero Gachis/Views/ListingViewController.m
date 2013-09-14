//
//  ListingViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 29/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "ListingViewController.h"
#import "CellMagNoA.h"
#import "CellMagA.h"
#import "ProfilNoPartnerViewController.h"
#import "ProfilPartnerViewController.h"
#import "AppDelegate.h"
#import "CellSeparation.h"
#import "Ville.h"
#import "Partenaire.h"
#import "Enseigne.h"
#import "Magasin.h"
#import "RestAPI.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AsyncImageView.h>
#import "Vote.h"

@interface ListingViewController ()

@end

@implementation ListingViewController
@synthesize ville,arrayMagasins;
@synthesize latitude,isMagasin,arrayProducts;
@synthesize Delegate;
@synthesize longitude;
@synthesize cellHaut;
@synthesize villeObj;

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
    
    
    isEndPartenaire = false;
    isMagasin = [[NSNumber alloc] initWithInt:0];
    
    
    Delegate = [[UIApplication sharedApplication] delegate];
  
    ;
    
    positionLimit = 0;
    for(int i=0;;i++){
        if([[self.arrayMagasins objectAtIndex:i] isKindOfClass:[Magasin class]])
        {
            positionLimit = i;
            break;
            
        }
    }
    if(positionLimit != 0){
        
        [self.arrayMagasins insertObject:@"test" atIndex:positionLimit];
        
    }
    
    
    
    [btnPartners setHighlighted:true];
//    [btnPartners setHighlighted:true];
    
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    
     scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 530);

    ville = [villeObj nom];
    
    if([ville length] > 10 && [ville length] < 20){
        
        [barCity setBounds:CGRectMake(barCity.bounds.origin.x-40, barCity.bounds.origin.y, barCity.bounds.size.width+40, barCity.bounds.size.height)];
        
        [villeLabel setBounds:CGRectMake(villeLabel.bounds.origin.x, villeLabel.bounds.origin.y, villeLabel.bounds.size.width+40, villeLabel.bounds.size.height)];
        
        
  
    }
    else if([ville length] > 20){
        [barCity setBounds:CGRectMake(barCity.bounds.origin.x, barCity.bounds.origin.y, barCity.bounds.size.width+80, barCity.bounds.size.height)];
        
        if([ville length] > 30){
            [villeLabel setBounds:CGRectMake(villeLabel.bounds.origin.x, villeLabel.bounds.origin.y, villeLabel.bounds.size.width+50, villeLabel.bounds.size.height)];
            
        }else{
            
        
            [villeLabel setBounds:CGRectMake(villeLabel.bounds.origin.x, villeLabel.bounds.origin.y, villeLabel.bounds.size.width+80, villeLabel.bounds.size.height)];
        }
    }
    
    
    NSString* text = [[NSString alloc] initWithFormat:@"    Près de %@ ",ville];
    
    
    
    
    [villeLabel setText:text];
    
    CGSize widthText = [villeLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0]];
    
    CGFloat presSize;
    if([ville length] < 30){
        
        presSize = (villeLabel.bounds.size.width/2)-(widthText.width/2);
        
    }else{
         presSize = 10;
    }
    
    
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(presSize, villeLabel.bounds.origin.y+5, 11, 11)];
    [image setImage:[UIImage imageNamed:@"arrow_ville"]];
    [villeLabel addSubview:image];
    
  
    /*
    [villeLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock: ^(NSMutableAttributedString *mutableAttributedString) {
        NSRange colorRange = [text rangeOfString: self.ville options: NSCaseInsensitiveSearch];
        if (colorRange.location != NSNotFound) {
            [mutableAttributedString addAttribute:(NSString *) kCTForegroundColorAttributeName value:(id)[[UIColor orangeColor] CGColor] range:colorRange];
        }
        return mutableAttributedString;
    }];
    
   */
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 50)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.shadowColor = [UIColor colorWithRed:112.0/255.0 green:168.0/255.0 blue:180.0/255.0 alpha:1];
    navLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"size:22];
    navLabel.textAlignment = UITextAlignmentCenter;
    navLabel.text=@"Magasins";
    self.navigationItem.titleView = navLabel;
    
    UIImage *backBtnImage = [UIImage imageNamed:@"bouton_retour"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    
    backBtnImage = [UIImage imageNamed:@"bouton_retour_hover"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateSelected];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 63, 40);
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = cancelButton;
    tableNoPartners.delegate = self;
    tableNoPartners.dataSource = self;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    villeLabel = nil;
    scrollView = nil;
    tableNoPartners = nil;
    [self setCellHaut:nil];
    btnPartners = nil;
    btnNoPartners = nil;
    barCity = nil;
    arrowCity = nil;
    tableViewListing = nil;
    [super viewDidUnload];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return  cellHaut;
    }
    else{
        if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Partenaire class]]){
            
            isMagasin = [[NSNumber alloc] initWithInt:0];
                static NSString *CellIdentifier = @"CellMagA";
                
                CellMagA *cell = (CellMagA *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                NSArray *nib;
                    if(indexPath.row == 1){
                       nib  = [[NSBundle mainBundle] loadNibNamed:@"CellMagFirst" owner:self options:nil];
                    }else{
                        nib = [[NSBundle mainBundle] loadNibNamed:@"CellMagA" owner:self options:nil];
                        
                    }
                    cell = [nib objectAtIndex:0];
                    
                    Partenaire *p = [self.arrayMagasins objectAtIndex:indexPath.row-1];
                    
                    [cell.labelEnseigne setText:[[NSString alloc] initWithFormat:@"%@",p.enseigne.nom]];
            
            
                    
                    CGSize widthText = [p.ville sizeWithFont:[UIFont systemFontOfSize:18.0]];
            
            
                    UIImageView * image;
                    image = [[UIImageView alloc]initWithFrame:CGRectMake(widthText.width+5, 2, 16, 16)];
                    [image setImage:[UIImage imageNamed:@"icone_pourcentage_yes"]];
                    [cell.labelVille addSubview:image];
                    [cell.labelVille setText:[[NSString alloc] initWithFormat:@"%@",p.ville]];
                    
                    widthText = [cell.labelRef.text sizeWithFont:[UIFont systemFontOfSize:14]];
                    image = [[UIImageView alloc]initWithFrame:CGRectMake(cell.labelRef.bounds.origin.x, cell.labelRef.bounds.origin.y, 8, 10)];
                    [image setImage:[UIImage imageNamed:@"ic_liste"]];
                    [cell.labelRef addSubview:image];
                    [cell.labelRef setText:[[NSString alloc] initWithFormat:@"    %@ Ref",p.somme_produits]];
                    
                    
                    widthText = [cell.labelRed.text sizeWithFont:[UIFont systemFontOfSize:14]];
                    image = [[UIImageView alloc]initWithFrame:CGRectMake(cell.labelRed.bounds.origin.x, cell.labelRed.bounds.origin.y, 11, 11)];
                    [image setImage:[UIImage imageNamed:@"ic_ref"]];
                    [cell.labelRed addSubview:image];
                    [cell.labelRed setText:[[NSString alloc] initWithFormat:@"    %@%%",p.reduction_moyenne]];
                    
                    widthText = [cell.labelKm.text sizeWithFont:[UIFont systemFontOfSize:14]];
                    image = [[UIImageView alloc]initWithFrame:CGRectMake(cell.labelKm.bounds.origin.x, cell.labelKm.bounds.origin.y, 9, 10)];
                    [image setImage:[UIImage imageNamed:@"ic_nav"]];
                    [cell.labelKm addSubview:image];
                    [cell.labelKm setText:[[NSString alloc] initWithFormat:@"  %@",p.distance]];
                    
                    
                    [cell.logo_mag setImageURL:[NSURL URLWithString:p.enseigne.logo_mobile]];
            
            
            
                return cell;
            
        }
        else if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Magasin class]]){
            isMagasin = [[NSNumber alloc] initWithInt:1];
            
            static NSString *CellIdentifier = @"CellMagNoA";
            
            CellMagNoA *cell = (CellMagNoA *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
           
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellMagNoA" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                
                
                
                Magasin *m = [self.arrayMagasins objectAtIndex:indexPath.row-1];
            
            
            
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(cell.labelMag.bounds.origin.x, cell.labelMag.bounds.origin.y, 16, 16)];
            
            
             if(m.votes_contre.intValue >= m.votes_pour.intValue){
                [image setImage:[UIImage imageNamed:@"icone_pourcentage_no"]];
                
            }
            else{
                
                [image setImage:[UIImage imageNamed:@"icone_pourcentage_yes"]];
                
            }
            
            [cell.labelMag addSubview:image];
            
           NSString *value =  [[NSString alloc] initWithFormat:@"       %@ - %@ (%@)",m.enseigne.nom,m.ville,m.distance];
           
            
            CGSize widthText = [value sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
            
            if(widthText.width > 255){
                value = @"passage";
                
                CGSize blanc = [@"            " sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
                
                 CGSize enseigne_name = [m.enseigne.nom sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
                
                
                CGSize distance = [m.distance sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
                
                NSString *ville_m;
                CGSize ville_size = CGSizeMake(300,300);
                int position = [m.ville length];
                
                
                while (position >= 0 && ville_size.width > (255 -(enseigne_name.width+distance.width+blanc.width)))
                {
                    ville_size  =[[[NSString alloc] initWithFormat:@"%@..",[m.ville substringToIndex:position]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
                    position = position - 1;
                    
                }
                
                if(position == -1){
                     ville_m = @"";
                }else{
                    ville_m = [[NSString alloc] initWithFormat:@"%@..",[m.ville substringToIndex:position]];
                }
                
                value =  [[NSString alloc] initWithFormat:@"       %@ - %@ (%@)",m.enseigne.nom,ville_m,m.distance];
                
                
                      
            }
            else{
                
            }
            
            
            [cell.labelMag setText:value];
            
                
                
            
            
            return cell;
        }
        else
        {

               
              static NSString *CellIdentifier = @"CellSeparation";
            
            modeView = 0;
            CellSeparation *cell = (CellSeparation *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellSeparation" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
        }
    }
        
        

    
    return cellHaut;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 105.0;
    }else if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Partenaire class]] && indexPath.row == 1){
        return 100;
        
    }else if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Partenaire class]]){
        return 90;
        // return 16;
    }
    else if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Magasin class]])
    {
       
        //90
        return 44;
    }
    
    return 16;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
        
    if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Partenaire class]])
    {
          
        
        partenaire = [self.arrayMagasins objectAtIndex:indexPath.row - 1];
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Chargement ...";
        hud.delegate = self;
        
        //On fait la requête
        [Delegate.restAPI getProducts:partenaire.idPartenaire];

        
          
    
    }
    else if([[self.arrayMagasins objectAtIndex:indexPath.row-1] isKindOfClass:[Magasin class]]){
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ListingStoryboard" bundle:nil];
        
        ProfilNoPartnerViewController *vp = [sb instantiateViewControllerWithIdentifier:@"ProfilNoPartnerView"];
        Magasin *m = [self.arrayMagasins objectAtIndex:indexPath.row - 1];
        
        Delegate.noPartnerViewController = vp;
        
        vp.magasin = m;
        [self.navigationController pushViewController:vp animated:YES];
    }
    return indexPath;
}

-(void)setTabProducts:(NSArray *)tabProducts
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    self.arrayProducts = [tabProducts mutableCopy];
    
    
    [hud hide:true];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ListingStoryboard" bundle:nil];
    ProfilPartnerViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ProfilPartnerView"];
    Delegate.partnerViewController = vc;
    vc.partenaire = partenaire;
    vc.arrayProducts = self.arrayProducts;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    

    
    
}

-(void)setVote:(Vote*)vote forMag:(Magasin*)mag
{
    Magasin *m = [self.arrayMagasins objectAtIndex:[self.arrayMagasins indexOfObject:mag]];
    [m setVote_client:[[NSString alloc] initWithFormat:@"%d",vote.vote.intValue]];
    [m setVotes_contre:vote.votes_contre];
    [m setVotes_pour:vote.votes_pour];
    
   
    
    CellMagNoA *noA =(CellMagNoA*)[tableViewListing cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrayMagasins indexOfObject:mag]+1 inSection:0]];
    
    [self.arrayMagasins replaceObjectAtIndex:[self.arrayMagasins indexOfObject:mag] withObject:m];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(noA.labelMag.bounds.origin.x, noA.labelMag.bounds.origin.y, 16, 16)];
    
    
    if(m.votes_contre.intValue >= m.votes_pour.intValue){
        [image setImage:[UIImage imageNamed:@"icone_pourcentage_no"]];
        
    }
    else{
        
        [image setImage:[UIImage imageNamed:@"icone_pourcentage_yes"]];
        
    }
    
    [noA.labelMag addSubview:image];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayMagasins.count + 1;
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
