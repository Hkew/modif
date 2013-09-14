//
//  ProfilNoPartnerViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 03/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "ProfilNoPartnerViewController.h"
#import "UtilForm.h"
#import "Enseigne.h"
#import "Magasin.h"
#import <AsyncImageView.h>
#import "AppDelegate.h"
#import "RestAPI.h"
#import "Vote.h"

@interface ProfilNoPartnerViewController ()

@end

@implementation ProfilNoPartnerViewController
@synthesize logo_mag,magasin,labelNon,labelOui,viewContentAll,boutonOk,labelMail,labelMerci,labelVille,labelVote1,boutonNon,boutonOui,Delegate,view_content;

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
    
    Delegate = [[UIApplication sharedApplication] delegate];
    
    
    if([Delegate.isIphone5 intValue] == 1){
        [viewContentAll setFrame:CGRectMake(viewContentAll.frame.origin.x, viewContentAll.frame.origin.y+50, viewContentAll.frame.size.width, viewContentAll.frame.size.height)];
    
    }
    
    NSLog(@"%d",[magasin.idMagasin integerValue]);
    labelVille.text = magasin.ville;
    
    if([magasin.votes_pour integerValue] < 30){
        labelOui.text = [[NSString alloc ]initWithFormat:@"%d/30",[magasin.votes_pour integerValue]];
        
    }
    else{
          labelOui.text = [[NSString alloc ]initWithFormat:@"%d/30",30];
    }
    
    
    if(30-[magasin.votes_contre integerValue] > 0){
        labelNon.text = [[NSString alloc ]initWithFormat:@"%d/30",30-[magasin.votes_pour integerValue]];
        
    }else{
        labelNon.text = [[NSString alloc ]initWithFormat:@"%d/30",0];
        
    }
    
    int vote_client = [magasin.vote_client intValue];
    
    if(vote_client == 1){
        boutonOui.highlighted = true;
    }
    
    if(vote_client == 0){
        boutonNon.highlighted = true;
    }
    NSLog(@"vote_client %d",[magasin.vote_client intValue]);
    
   // magasin.vote_client
    
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
    navLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    navLabel.text=magasin.ville;
    self.navigationItem.titleView = navLabel;
    
    [logo_mag setImageURL:[NSURL URLWithString:magasin.enseigne.logo_mobile]];
    
    
    //image
    UIImage *backgroundImage = [UIImage imageNamed:@"fond_bar"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navBar setTintColor:[UIColor whiteColor]];
    
    
    /**************************/
  
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20, textEmail.bounds.size.height)];
    textEmail.leftView = leftView;
    
    textEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 47, textEmail.bounds.size.height)];
    textEmail.rightView = rightView;
    
    textEmail.rightViewMode = UITextFieldViewModeAlways;
    
    
   textEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"mail"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    

	// Do any additional setup after loading the view.
}



- (void)keyboardWillShow:(NSNotification *)n
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:0.3];
    if(textEmail.isFirstResponder){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        
        
        
        [view_content setFrame:CGRectMake(view_content.frame.origin.x,0,view_content.frame.size.width,view_content.frame.size.height)];
       
        [UIView commitAnimations];
        
        
    }
    [UIView commitAnimations];
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == textEmail){
        
        [textEmail resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        
        
          [view_content setFrame:CGRectMake(view_content.frame.origin.x,214,view_content.frame.size.width,view_content.frame.size.height)];
         [UIView commitAnimations];
        
       // [self goToThank:nil];
        /*if(textField.text.length == 0){
            [textField resignFirstResponder];
            self.autocompleteTableView.hidden = true;
            imgEndKeyboard.hidden = true;
            imgGeolocInfo.hidden = false;
            btnSearch.hidden = true;
            textGeoloc.text = @"";
            [viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x, 205, viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
            [UIView commitAnimations];
            
        }else{
            [self goSearch:nil];
            
        }
         */
        //[textGeoloc resignFirstResponder];
    }
    return YES;
}

- (void)keyboardWillHide:(NSNotification *)n
{
    
    /*
     
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationBeginsFromCurrentState:YES];
     // The kKeyboardAnimationDuration I am using is 0.3
     [UIView setAnimationDuration:0.3];
     if(textGeoloc.isFirstResponder)[viewGeoloc setFrame:CGRectMake(viewGeoloc.frame.origin.x,175,viewGeoloc.frame.size.width,viewGeoloc.frame.size.height)];
     [UIView commitAnimations];
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    btnNoA = nil;
    btnYesA = nil;
    questionA = nil;
    questionB = nil;
    btnYesB = nil;
    btnNoB = nil;
    btnNoC = nil;
    btnYesC = nil;
    questionC = nil;
    textEmail = nil;
    viewQ3 = nil;
    [self setLogo_mag:nil];
    [self setLabelVille:nil];
    [self setLabelNon:nil];
    [self setLabelOui:nil];
    [self setView_content:nil];
    [self setLabelVote1:nil];
    [self setLabelMail:nil];
    [self setLabelMerci:nil];
    [self setBoutonOk:nil];
    [self setBoutonOui:nil];
    [self setBoutonNon:nil];
    [self setViewContentAll:nil];
    [super viewDidUnload];
}
- (IBAction)goToQ3No:(id)sender {
    [self goToQ3:nil];
}

- (IBAction)goToQ2No:(id)sender {
    [self goToQ2:nil];
}

- (IBAction)goToThank:(id)sender {
    
    if(textEmail.text.length > 0 || [UtilForm NSStringIsValidEmail:textEmail.text]){
        
        if(textEmail.isFirstResponder){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        
        
        [viewQ3 setFrame:CGRectMake(viewQ3.frame.origin.x,219,viewQ3.frame.size.width,viewQ3.frame.size.height)];
        
        [textEmail resignFirstResponder];
        [UIView commitAnimations];
        }
        
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Vous devez spécifier une adresse email valide" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        
    }

    
}

- (IBAction)goToQ3:(id)sender {
    
    btnNoB.hidden = true;
    btnYesB.hidden = true;
    questionB.hidden = true;
    
    
    btnNoC.hidden = false;
    btnYesC.hidden = false;
    questionC.hidden = false;
    textEmail.hidden = false;
    
}

- (IBAction)goToQ2:(id)sender {
    btnNoA.hidden = true;
    btnYesA.hidden = true;
    questionA.hidden = true;
    
    
    btnNoB.hidden = false;
    btnYesB.hidden = false;
    questionB.hidden = false;
}

- (void)setVote:(Vote*)vote
{
    //On va mettre à jour aussi dans le tableau des magasins
    [Delegate.listingViewController setVote:vote forMag:magasin];
   
    if([vote.votes_pour integerValue] < 30){
        labelOui.text = [[NSString alloc ]initWithFormat:@"%d/30",[vote.votes_pour integerValue]];
        
    }
    else{
        labelOui.text = [[NSString alloc ]initWithFormat:@"%d/30",30];
    }
    
    
    if(30-[vote.votes_contre integerValue] > 0){
        labelNon.text = [[NSString alloc ]initWithFormat:@"%d/30",30-[vote.votes_pour integerValue]];
        
    }else{
        labelNon.text = [[NSString alloc ]initWithFormat:@"%d/30",0];
        
    }
    
      
    [hud hide:true];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    labelVote1.hidden = true;
    boutonOui.hidden = true;
    boutonNon.hidden = true;
    
    boutonOk.hidden= false;
    labelMail.hidden = false;
    textEmail.hidden = false;
    
    [UIView commitAnimations];
    
}

- (IBAction)voteOui:(id)sender {
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Chargement ...";
    hud.delegate = self;
    [Delegate.restAPI sendVote:[[NSNumber alloc] initWithInt:1] forMag:magasin.idMagasin];
}
- (IBAction)voteNon:(id)sender {
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Chargement ...";
    hud.delegate = self;
    [Delegate.restAPI sendVote:[[NSNumber alloc] initWithInt:0] forMag:magasin.idMagasin];
}
- (IBAction)sendEmail:(id)sender {
    
    [textEmail resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    
    [view_content setFrame:CGRectMake(view_content.frame.origin.x,214,view_content.frame.size.width,view_content.frame.size.height)];
    [UIView commitAnimations];

    
    if(textEmail.text.length > 0 || [UtilForm NSStringIsValidEmail:textEmail.text])
    {
        
        
        [[NSUserDefaults standardUserDefaults] setObject:textEmail.text forKey:@"mail"];
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Chargement ...";
        hud.delegate = self;
        
        //On va mettre à jour aussi dans le tableau des magasins
        [Delegate.restAPI sendMail:textEmail.text forMag:magasin.idMagasin];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Vous devez spécifier une adresse email valide" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        

    }

    
}


- (void) getError
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    [hud hide:true];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de réseau" message:@"Un problème est intervenu avec notre serveur. Veuillez nous excuser." delegate:self cancelButtonTitle:@"Fermer" otherButtonTitles:nil];
    
    [alert show];
    
}




-(void)setMerci
{
    [hud hide:true];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    
    textEmail.hidden = true;
    boutonOk.hidden = true;
    labelMail.hidden = true;
    
    labelMerci.hidden = false;
    
    [UIView commitAnimations];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(goback) userInfo:nil repeats:NO];
    

}


@end
