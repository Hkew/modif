//
//  MenuViewController.m
//  Zero Gachis
//
//  Created by Tony Cois on 02/04/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "MenuViewController.h"
#import "CellMenuHeader.h"
#import "CellMenuItem.h"

@interface MenuViewController ()

@end
@implementation MenuViewController
@synthesize Delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToZGInfo:(id)sender {
    Delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MenuStoryboard" bundle:nil];
    Delegate.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[sb instantiateViewControllerWithIdentifier:@"MenuViewController"]];
}

- (IBAction)goToHome:(id)sender {
     Delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    Delegate.viewController.centerPanel = Delegate.navController;
    
}
- (void)viewDidUnload {
    menuTable = nil;
    [super viewDidUnload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    if(indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5){
        static NSString *CellIdentifier = @"CellMenuHeader";
        
        CellMenuHeader *cell = (CellMenuHeader *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellMenuHeader" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            switch (indexPath.row) {
                case 0:
                    [cell setLabelText:@"Général"];
                    break;
                    
                    
                case 2:
                    [cell setLabelText:@"En savoir plus"];
                    break;
                
                case 5:
                    [cell setLabelText:@"Soutenez nous"];
                    break;
                default:
                    break;
            }
        }
        
    
        
        return cell;
    }
    
    if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8){
        static NSString *CellIdentifier = @"CellMenuItem";
        
        CellMenuItem *cell = (CellMenuItem *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellMenuItem" owner:self options:nil];
            cell = [nib objectAtIndex:0];
          
            
            
          
            [cell setInfos:indexPath.row];
            
        }
        return cell;
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 || indexPath.row == 2  || indexPath.row == 5)
    {
        return 22;
    }
    else if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8)
    {
        return 44;
    }
    

    return 44;

}


- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MenuStoryboard" bundle:nil];
    NSURL *urlInterneFB = [NSURL URLWithString:@"fb://profile/141126412654829"];
    NSURL *urlInterneTwitter = [NSURL URLWithString:@"twitter://user?screen_name=ZeroGachis"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
    switch (indexPath.row) {
        case 1:
            
            Delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            
            Delegate.viewController.centerPanel = Delegate.navController;
            
            break;
        case 3:
            
            Delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            Delegate.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[sb instantiateViewControllerWithIdentifier:@"GuideController"]];
            
            
            break;
        case 4:
            
            Delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            Delegate.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[sb instantiateViewControllerWithIdentifier:@"ZGController"]];
            
            
            break;
        case 6:
            
            if ([[UIApplication sharedApplication] canOpenURL:urlInterneTwitter])
            {
                [[UIApplication sharedApplication] openURL:urlInterneTwitter];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ZeroGachis"]];
            }
            
            break;
        case 7:
            
            if ([[UIApplication sharedApplication] canOpenURL:urlInterneFB])
            {
                [[UIApplication sharedApplication] openURL:urlInterneFB];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/ZeroGachis"]];
            }
            
            break;

         
        case 8:
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/apps/ZeroGachis"]];
            
            
            break;
        
        default:
            return indexPath;
            break;
    }
   
    
    return indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 9;
}


@end
