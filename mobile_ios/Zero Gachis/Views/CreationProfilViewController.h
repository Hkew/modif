//
//  CreationProfilViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//


// OBJECT : Ce controller n'est pas utilisé mais pourrait l'être à l'avenir
//          Il était dans la version 0.0.1 avant d'être sauté


#import <UIKit/UIKit.h>

@class Config;

@interface CreationProfilViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIImageView *midView;
    
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *prenomField;
    IBOutlet UITextField *dateField;
    
    IBOutlet UITextField *mailField;
    IBOutlet UITextField *codeField;
    
    IBOutlet UIView *formView;
    UIDatePicker *datePicker;
    Config *config;
    IBOutlet UIImageView *nuage;
    IBOutlet UIImageView *barImg;
    IBOutlet UITextField *repassField;
    IBOutlet UITextField *passField;
    IBOutlet UIScrollView *viewScroll;
}

@end
