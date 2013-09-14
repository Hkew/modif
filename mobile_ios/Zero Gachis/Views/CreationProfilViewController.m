//
//  CreationProfilViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//


// OBJECT : Ce controller n'est pas utilisé mais pourrait l'être à l'avenir
//          Il était dans la version 0.0.1 avant d'être sauté

#import "CreationProfilViewController.h"
#import "AppDelegate.h"
#import "Config.h"

@interface CreationProfilViewController ()

@end

@implementation CreationProfilViewController

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
    /* Configuraiton de la view */
    //Conf de la barre
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
   
    config = [appDelegate config];
    if(config.isIphone5.integerValue == 1){
        [viewScroll setFrame:CGRectMake(viewScroll.frame.origin.x,viewScroll.frame.origin.y-90,viewScroll.frame.size.width, viewScroll.frame.size.height+100)];
        [nuage setFrame:CGRectMake(nuage.frame.origin.x,nuage.frame.origin.y,231,17)];
         [barImg setFrame:CGRectMake(barImg.frame.origin.x,barImg.frame.origin.y,241,73)];
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
    
    
    viewScroll.contentSize = CGSizeMake(viewScroll.frame.size.width, 530);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, nameField.bounds.size.height)];
    nameField.leftView = leftView;
    nameField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, nameField.bounds.size.height)];
    nameField.rightView = rightView;
    nameField.rightViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftViewPrenom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, prenomField.bounds.size.height)];
    prenomField.leftView = leftViewPrenom;
    prenomField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightViewPrenom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, prenomField.bounds.size.height)];
    prenomField.rightView = rightViewPrenom;
    prenomField.rightViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftViewDate = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, dateField.bounds.size.height)];
    dateField.leftView = leftViewDate;
    dateField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightViewDate = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, dateField.bounds.size.height)];
    dateField.rightView = rightViewDate;
    dateField.rightViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftViewCode = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, codeField.bounds.size.height)];
    codeField.leftView = leftViewCode;
    codeField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightViewCode = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, codeField.bounds.size.height)];
    codeField.rightView = rightViewCode;
    codeField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftViewMail = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, mailField.bounds.size.height)];
    mailField.leftView = leftViewMail;
    mailField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightViewMail = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, mailField.bounds.size.height)];
    mailField.rightView = rightViewMail;
    mailField.rightViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftViewPass = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, passField.bounds.size.height)];
    passField.leftView = leftViewPass;
    passField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightViewPass = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, passField.bounds.size.height)];
    passField.rightView = rightViewPass;
    passField.rightViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftViewRePass = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44, repassField.bounds.size.height)];
    repassField.leftView = leftViewRePass;
    repassField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightViewRePass = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, passField.bounds.size.height)];
    repassField.rightView = rightViewRePass;
    repassField.rightViewMode = UITextFieldViewModeAlways;
    /*
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
               // [self updateView];
            }];
        }
    }
    */
    
    
	// Do any additional setup after loading the view.
}
/*


- (void)keyboardWillShow:(NSNotification *)n
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:0.3];
    if(nameField.isFirstResponder || prenomField.isFirstResponder || dateField.isFirstResponder || codeField.isFirstResponder || passField.isFirstResponder || repassField.isFirstResponder || mailField.isFirstResponder){
        
       
            [formView setFrame:CGRectMake(formView.frame.origin.x,-90,formView.frame.size.width,formView.frame.size.height)];
            
        
    
        
    }
    [UIView commitAnimations];
        
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     
    if(textField == nameField){

        [prenomField becomeFirstResponder];
        
        
    }
    if(textField == prenomField){
        
        [dateField becomeFirstResponder];
    }
    if(textField == dateField){
        [codeField becomeFirstResponder];
    }
    if(textField == codeField){
        [mailField becomeFirstResponder];
        if(config.isIphone5.integerValue == 0){
            
          [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
    }
    
    if(textField == mailField){
        
        [passField becomeFirstResponder];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }

      
    }
    if(textField == passField){
        [repassField becomeFirstResponder];
    }
    if(textField == repassField){
        [repassField resignFirstResponder];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        

        
        [self checkInscription:nil];
    }
    
  
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == codeField){
         [formView setFrame:CGRectMake(formView.frame.origin.x,-90,formView.frame.size.width,formView.frame.size.height)];
    }
    
    if(textField == mailField){
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }

       
    }
    
    
   
    if(textField == dateField){
        
        datePicker = [[UIDatePicker alloc]init];
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        
        NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
        mmddccyy.timeStyle = NSDateFormatterNoStyle;
        mmddccyy.dateFormat = @"dd/MM/yyyy";
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];

        NSInteger year = [components year]-13;
        NSDate *dMax = [mmddccyy dateFromString:[[NSString alloc] initWithFormat:@"01/01/%d",year]];
      
        datePicker.maximumDate = dMax;
        NSDate *dMin = [mmddccyy dateFromString:@"01/01/1900"];
        datePicker.minimumDate = dMin;
        
        if([dateField.text length] != 0){
            datePicker.date = [mmddccyy dateFromString:dateField.text];
            
        }
        
        
        dateField.inputView = datePicker;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    midView = nil;
    nameField = nil;
    prenomField = nil;
    dateField = nil;
    codeField = nil;
    formView = nil;
    viewScroll = nil;
    mailField = nil;
    passField = nil;
    repassField = nil;
    barImg = nil;
    nuage = nil;
    [super viewDidUnload];
}
- (IBAction)showFBLogin:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        
        [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        
        NSArray *permissions = [NSArray arrayWithObjects: @"user_birthday", @"email",@"user_location", nil];
        
       
        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session,
           FBSessionState state, NSError *error) {
               [self sessionStateChanged:session state:state error:error];
             
             
             
         }];
        
    }
}

- (IBAction)endDatePicker:(id)sender {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    
    NSString *stringFromDate = [formatter stringFromDate:datePicker.date];
    dateField.text = stringFromDate;
    

}

- (void) resignVal
{
    
}

- (IBAction)checkInscription:(id)sender {
    
    if([nameField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez spécifier un nom" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
        [alert show];
        
        [formView setFrame:CGRectMake(formView.frame.origin.x,-90,formView.frame.size.width,formView.frame.size.height)];
        [nameField becomeFirstResponder];
    }
    else if([prenomField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez spécifier un prenom" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
          [formView setFrame:CGRectMake(formView.frame.origin.x,-90,formView.frame.size.width,formView.frame.size.height)];
        [prenomField becomeFirstResponder];
        
    }else if([codeField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez spécifier un code postal" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
         [formView setFrame:CGRectMake(formView.frame.origin.x,-90,formView.frame.size.width,formView.frame.size.height)];
        [codeField becomeFirstResponder];
    }else if([mailField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez spécifier un mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        

        [mailField becomeFirstResponder];
    }else if(![self NSStringIsValidEmail:mailField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous adresse e-mail n'est pas valide" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        

        [mailField becomeFirstResponder];
    }else if([passField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez spécifier un mot de passe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        

        [passField becomeFirstResponder];
    }else if([passField.text length] < 6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez avoir un mot de passe d'au moins 6 caractères" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        [passField becomeFirstResponder];
        
    }else if([repassField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Vous devez répéter votre mot de passe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        

        [repassField becomeFirstResponder];
    }else if(![passField.text isEqualToString:repassField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Les mots de passe de correspondent pas." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(config.isIphone5.integerValue == 0){
            
            [formView setFrame:CGRectMake(formView.frame.origin.x,-210,formView.frame.size.width,formView.frame.size.height)];
        }else{
            [formView setFrame:CGRectMake(formView.frame.origin.x,-140,formView.frame.size.width,formView.frame.size.height)];
        }
        

        [repassField becomeFirstResponder];
    }
    else{
        [formView setFrame:CGRectMake(formView.frame.origin.x,102,formView.frame.size.width,formView.frame.size.height)];
        NSLog(@"INSCRIPTION EN COURS");
        [repassField resignFirstResponder];
        [nameField resignFirstResponder];
        [prenomField resignFirstResponder];
        [codeField resignFirstResponder];
        [dateField resignFirstResponder];
        [passField resignFirstResponder];
        [mailField resignFirstResponder];
        
        NSArray *info = [NSArray arrayWithObjects: nameField.text, prenomField.text,dateField.text,codeField.text,mailField.text,passField.text,nil];
        [self inscriptionUser:info];
    }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)inscriptionUser:(NSArray *)tab{
    
    NSLog(@"tab info : %@",tab);
    
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            [self getInfoUser];
            
            UIViewController *topViewController =
            [self.navigationController topViewController];
            
            
            if ([[topViewController modalViewController]
                 isKindOfClass:[CreationProfilViewController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }    
}

- (void) getInfoUser
{
   
    FBRequest *me = [FBRequest requestForMe];
    
    
    [me startWithCompletionHandler:^(FBRequestConnection *connection,
                                     NSDictionary<FBGraphUser> *result,
                                     NSError *error) {
        
        NSRange rangeOfDash = [result.location.name rangeOfString:@","];
        NSString *ville = (rangeOfDash.location != NSNotFound) ? [result.location.name substringToIndex:rangeOfDash.location] : nil;
        

        
        NSArray *info = [NSArray arrayWithObjects: result.last_name, result.first_name,result.birthday,ville,[result objectForKey:@"email"],nil,nil];
        [self inscriptionUser:info];
        
    
               
        
    }];

}
*/
@end
