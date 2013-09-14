//
//  ZGController.m
//  Zero Gachis
//
//  Created by Tony Cois on 04/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "ZGController.h"
#import "AppDelegate.h"
#import "GuideCell.h"

@interface ZGController ()

@end

@implementation ZGController
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
    
 //   [self scrollViewDidScroll:self.tableViewZG];
    self.tableViewZG.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    
    Delegate = [[UIApplication sharedApplication]delegate];
    
    
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
    navLabel.text=@"Zéro Gâchis";
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

/*

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [self.tableViewZG visibleCells];
    
    if (visibleCells != nil  &&  [visibleCells count] != 0) {       // Don't do anything for empty table view
        
        UITableViewCell *topCell = [visibleCells objectAtIndex:0];
        UITableViewCell *bottomCell = [visibleCells lastObject];
        
        // Avoids issues with skipped method calls during rapid scrolling
        for (UITableViewCell *cell in visibleCells) {
            //      cell.contentView.alpha = 1.0;
        }
        
        NSInteger cellHeight = topCell.frame.size.height - 1;   // -1 To allow for typical separator line height
        NSInteger tableViewTopPosition = self.tableViewZG.frame.origin.y;
        NSInteger tableViewBottomPosition = self.tableViewZG.frame.origin.y + self.tableViewZG.frame.size.height;
        
        CGRect topCellPositionInTableView = [self.tableViewZG rectForRowAtIndexPath:[self.tableViewZG indexPathForCell:topCell]];
        CGRect bottomCellPositionInTableView = [self.tableViewZG rectForRowAtIndexPath:[self.tableViewZG indexPathForCell:bottomCell]];
        CGFloat topCellPosition = [self.tableViewZG convertRect:topCellPositionInTableView toView:[self.tableViewZG superview]].origin.y;
        CGFloat bottomCellPosition = ([self.tableViewZG convertRect:bottomCellPositionInTableView toView:[self.tableViewZG superview]].origin.y + cellHeight);
        
        CGFloat modifier = 1.5;    
 
        CGFloat topCellOpacity = (1.0f - ((tableViewTopPosition - topCellPosition) / cellHeight) * modifier);
        CGFloat bottomCellOpacity = (1.0f - ((bottomCellPosition - tableViewBottomPosition) / cellHeight) * modifier);
        
        if (topCell) {
            topCell.contentView.alpha = topCellOpacity;
        }
        if (bottomCell) {
            bottomCell.contentView.alpha = bottomCellOpacity;
        }
    }
}

*/
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
    if(indexPath.row == 6){
        return 100;
    }
    
    if(indexPath.row == 4){
        return 471;
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
            [cell.textview_guide setText:@"A la base, c’est 3 étudiants qui ont tout lâché pour accomplir une GRANDE mission..."];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
             break;
            
        case 2:
            [cell.logo_guide setBounds:CGRectMake(120, cell.logo_guide.bounds.origin.y, 202,80)];
            [cell.logo_guide setImage:[UIImage imageNamed:@"zg_2"]];
            
            [cell.textview_guide setText:@"Paul-Adrien, Christophe et Nicolas ont décidé d’unir leurs forces dans le but de réduire le gaspillage alimentaire en France."];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
            break;
        case 3:
            [cell.logo_guide setImage:[UIImage imageNamed:@"zg_3"]];
            [cell.textview_guide setText:@"Comment? En aidant les grandes surfaces à moins jeter !"];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            

                       break;
        case 4:
            nib = [[NSBundle mainBundle] loadNibNamed:@"ZGCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            [cell.logo_guide setImage:[UIImage imageNamed:@"guide_6"]];
            [cell.textview_guide setText:@"Grâce à www.zero-gachis.com et à des zones “Zéro-Gâchis” installées dans les magasins partenaires..."];
            
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
            return cell;
            break;
        case 5:
            [cell.logo_guide setImage:[UIImage imageNamed:@"zg_5"]];
            [cell.textview_guide setText:@"... c'est tout une communauté qui arrive à diviser par 2 le gaspillage alimentaire !! Et c’est encore loin de l’objectif qu’ils se sont fixés... ;)"];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
            cell.textview_guide.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
            
            break;
        case 6:
            [cell.logo_guide setImage:[UIImage imageNamed:@"zg_5"]];
            [cell.textview_guide setText:@"Aidez-nous vous aussi dans cette BELLE mission ! Rejoignez la communauté et participez au Guide !"];
            
            topCorrect = ([cell.textview_guide bounds].size.height - [cell.textview_guide contentSize].height * [cell.textview_guide zoomScale])/2.0;
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
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

-(void)goPanel
{
    [Delegate.viewController showLeftPanelAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableViewZG:nil];
    [super viewDidUnload];
}
@end
