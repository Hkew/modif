//
//  ConnexionViewController.h
//  Zero Gachis
//
//  Created by Tony Cois on 26/03/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

// OBJECT : Ce controller n'est pas utilisé mais pourrait l'être à l'avenir
//          Il était dans la version 0.0.1 avant d'être sauté

#import <UIKit/UIKit.h>
#import "Config.h"

@interface ConnexionViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UITextField *mailField;
    IBOutlet UITextField *passField;
    IBOutlet UIView *viewForm;
    Config *config;
}

@end
