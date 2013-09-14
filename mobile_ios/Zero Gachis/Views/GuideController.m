//
//  GuideController.m
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "GuideController.h"
#import "AppDelegate.h"
#import "GuideCell.h"

@interface GuideController ()

@end

@implementation GuideController
@synthesize Delegate,tableViewGuide;

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
    
    self.tableViewGuide.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /**** Conf de la barre ****/
    
    Delegate = [[UIApplication sharedApplication]delegate];
    
    
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    [navBar setTranslucent:true];
    
    //Label titre
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 50)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.shadowColor = [UIColor colorWithRed:112.0/255.0 green:168.0/255.0 blue:180.0/255.0 alpha:1];
    navLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"size:22];
    navLabel.textAlignment = UITextAlignmentCenter;
    navLabel.text=@"Guide";
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
    

	// Do any additional setup after loading the view.
}

-(void)goPanel
{
     [Delegate.viewController showLeftPanelAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 7){
        return 100;
    }
    
    if(indexPath.row == 0){
        return 50;
    }
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GuideCell";
    
    GuideCell *cell = (GuideCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GuideCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    CGFloat topCorrect;
    switch (indexPath.row) {
        case 1:
              [cell.textview_guide setText:@"Le Guide Zéro-Gâchis est un outil pour réduire le gaspillage alimentaire en économisant de l'argent."];
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};

            break;
        
        case 2:
            [cell.logo_guide setImage:[UIImage imageNamed:@"guide_2"]];
            
            [cell.textview_guide setText:@"L’idée est de cartographier TOUTES les grandes surfaces responsables aux yeux de Zéro-Gâchis..."];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};

            break;
        case 3:
            [cell.logo_guide setImage:[UIImage imageNamed:@"guide_3"]];
            [cell.textview_guide setText:@"... c’est à dire celles qui appliquent des démarques sur les produits proches de leur date limite (DLC)..."];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
            break;
        case 4:
            [cell.logo_guide setImage:[UIImage imageNamed:@"guide_4"]];
            [cell.textview_guide setText:@"... afin que ces produits finissent dans VOS assiettes plutôt que dans leurs poubelles !"];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            break;
        case 5:
            [cell.logo_guide setImage:[UIImage imageNamed:@"guide_5"]];
            [cell.textview_guide setText:@"Aidez la communauté des Zéro-Gâcheurs en indiquant vous-même où trouver ces magasins engagés dans la lutte anti-gaspi"];
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
            break;
        case 6:
            [cell.logo_guide setImage:[UIImage imageNamed:@"guide_6"]];
            [cell.textview_guide setText:@"Merci !"];
            [cell.text_second_guide setText:@"et n'oubliez pas d'aller voter ;-)"];
            cell.text_second_guide.hidden = false;
            [cell.text_second_guide setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
            
            [cell.textview_guide setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:50]];
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            topCorrect = topCorrect - 20;
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
            break;
         default:
            cell.logo_guide.hidden = true;
            cell.textview_guide.hidden = true;
            cell.text_guide.hidden = true;
            break;
    }
    
    return cell;
    
}
- (void)viewDidUnload {
    [self setTableViewGuide:nil];
    [super viewDidUnload];
}
@end
