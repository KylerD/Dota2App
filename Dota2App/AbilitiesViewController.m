//
//  AbilitiesViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import "AbilitiesViewController.h"
#import "AppDelegate.h"
#import "Ability.h"
#import "DetailViewController.h"
#import "AbilityCell.h"
#import "AbilityDetailViewController.h"

@interface AbilitiesViewController ()
- (void)configureView;
@end

@implementation AbilitiesViewController
@synthesize hero;
@synthesize tableView;

#pragma mark - View LifeCycle

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

    
    hero = ((DetailViewController *)self.parentViewController).hero;
    
    if (hero) {

        [self configureView];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    abilities = [hero.abilities allObjects];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [abilities count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Ability *ability = [abilities objectAtIndex:[indexPath row]];
    

    if ([ability.notes isEqualToString: @""]) {
        return 180;
    }
    else{
        // FLT_MAX here simply means no constraint in height
        CGSize maximumLabelSize = CGSizeMake(768, FLT_MAX);
    
        CGSize expectedLabelSize = [ability.notes sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap];
    
        NSLog(@"%f",expectedLabelSize.height);
        if (expectedLabelSize.height+150<180) {
            return 180;
        }else{
            return expectedLabelSize.height+150;
        }
    }
    
}
 
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AbilityCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(NSString *)controller:(NSFetchedResultsController *)controller
sectionIndexTitleForSectionName:(NSString *)sectionName {
    return sectionName;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{   //Fetch the hero
    AbilityCell *abilityCell = (AbilityCell *)cell;
    
    Ability *ability = [abilities objectAtIndex:[indexPath row]];
    
    abilityCell.abilityName.text = ability.name;
    abilityCell.lore.text = ability.notes;
    
    abilityCell.lore.lineBreakMode = UILineBreakModeWordWrap;
    abilityCell.lore.numberOfLines = 0;
    
    [abilityCell.lore sizeToFit];
//    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:ability.imagePath]) {
        abilityCell.icon.image = [UIImage imageWithContentsOfFile:ability.imagePath];
    }
    
    
[abilityCell.icon setFrame:CGRectMake(abilityCell.icon.frame.origin.x,abilityCell.icon.frame.origin.y, 69,69)];
    [abilityCell isPassive:[ability.isPassive boolValue]];
    
    NSString * mc = ability.mc;
    
    if([mc isEqualToString:@""]){
        mc = @"Free";
    }
    
    abilityCell.mp.text= mc;
    
    NSString * cd = ability.cd;
    
    if([cd isEqualToString:@""]){
        cd = @"0";
    }    
    
    abilityCell.cd.text = cd;
    
    
    if(abilityCell.lore.frame.size.height>65){
    
    abilityCell.cd.frame = CGRectMake(abilityCell.cd.frame.origin.x,abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + 20, abilityCell.cd.frame.size.width, abilityCell.cd.frame.size.width);
    
    abilityCell.mp.frame = CGRectMake(abilityCell.mp.frame.origin.x,abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + 20, abilityCell.mp.frame.size.width, abilityCell.mp.frame.size.width);
    
    abilityCell.mpIcon.frame = CGRectMake(abilityCell.mpIcon.frame.origin.x,abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + 20, abilityCell.mpIcon.frame.size.width, abilityCell.mpIcon.frame.size.width);
    abilityCell.cdIcon.frame  =CGRectMake(abilityCell.cdIcon.frame.origin.x,abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + 20, abilityCell.cdIcon.frame.size.width, abilityCell.cdIcon.frame.size.width);
     
    }
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AbilityDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Ability *selectedAbility = [abilities objectAtIndex: [indexPath row]];
      AbilityDetailViewController *abilityDetailVC = (AbilityDetailViewController *)[segue destinationViewController];
      [abilityDetailVC setAbility:selectedAbility];

    }
}

@end