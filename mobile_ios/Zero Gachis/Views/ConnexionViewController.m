//
//  ConnexionViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//


// OBJECT : Ce controller n'est pas utilisé mais pourrait l'être à l'avenir
//          Il était dans la version 0.0.1 avant d'être sauté

#import "ConnexionViewController.h"
#import "Config.h"
#import "AppDelegate.h"
@interface ConnexionViewController ()

@end

@implementation ConnexionViewController

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
    
    //Conf de la barre
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    config = [appDelegate config];
    
    if(config.isIphone5.integerValue==1){
        [viewForm setFrame:CGRectMake(viewForm.frame.origin.x,viewForm.frame.origin.y-50,viewForm.frame.size.width, viewForm.frame.size.height)];
        
    }
    
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"btn-retour"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 75, 75);
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    [navBar setTranslucent:true];
    UIImage *backgroundImage = [UIImage imageNamed:@"bar_bg_with_title"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 42, mailField.bounds.size.height)];
    mailField.leftView = leftView;
    mailField.leftViewMode = UITextFieldViewModeAlways;
   
    UIView *leftViewMode = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 42, passField.bounds.size.height)];
    passField.leftView = leftViewMode;
    passField.leftViewMode = UITextFieldViewModeAlways;
  
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, mailField.bounds.size.height)];
    mailField.rightView = rightView;
    mailField.rightViewMode = UITextFieldViewModeAlways;
   
    UIView *rightViewMode = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, passField.bounds.size.height)];
    passField.rightView = rightViewMode;
    passField.rightViewMode = UITextFieldViewModeAlways;
    
    

	// Do any additional setup after loading the view.
}

- (void)keyboardWillShow:(NSNotification *)n
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:0.3];
    if(mailField.isFirstResponder || passField.isFirstResponder){
        
        
        [viewForm setFrame:CGRectMake(viewForm.frame.origin.x,-25,viewForm.frame.size.width,viewForm.frame.size.height)];
       
    }
    [UIView commitAnimations];
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"PASSAGE");
    
    if(textField == mailField){
        [mailField resignFirstResponder];
    }
    
    if(textField == passField){
        [passField resignFirstResponder];
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    mailField = nil;
    passField = nil;
    viewForm = nil;
    [super viewDidUnload];
}
@end
