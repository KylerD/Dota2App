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
    
    int manaCoolDownHeight = 0;
    
    if (![ability.mc isEqualToString:@""]) {
        manaCoolDownHeight = 50;
    }
    
    if ([ability.notes isEqualToString: @""]) {
        return 110+manaCoolDownHeight;
    }
    else{
        // FLT_MAX here simply means no constraint in height
        CGSize maximumLabelSize = CGSizeMake(541, FLT_MAX);
        
        CGSize expectedLabelSize = [ability.notes sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap];
        
        NSLog(@"%f",expectedLabelSize.height);
        if (expectedLabelSize.height+80<110) {
            return 110+manaCoolDownHeight;
        }else{
            return expectedLabelSize.height+80+manaCoolDownHeight;
        }
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AbilityCell";
    AbilityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AbilityCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
         [self.tableView reloadData];
        // Set up your cell
    }
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
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:ability.imagePath]) {
        abilityCell.icon.image = [UIImage imageWithContentsOfFile:ability.imagePath];
        
    } else {
        //In this case image path is just the bundled image name.
        abilityCell.icon.image = [UIImage imageNamed:ability.imagePath];
        
    }
    
    int yOrigin = abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + 20;
    
    if (yOrigin <100) {
        yOrigin = 100;
    }
    
    if (![ability.mc isEqualToString:@""]) {
        [abilityCell.mpIcon removeFromSuperview];
        [abilityCell.mp removeFromSuperview];
        
        abilityCell.mpIcon = [[UIImageView alloc] init];
        abilityCell.mpIcon.image = [UIImage imageNamed:@"manaCost.png"];
        abilityCell.mpIcon.frame = CGRectMake(50, yOrigin,25,25);
        [abilityCell addSubview:abilityCell.mpIcon];
        
        
        abilityCell.mp = [[UILabel alloc] init];
        abilityCell.mp.text = ability.mc;
        abilityCell.mp.frame = CGRectMake(80, yOrigin, 400,40);
        [abilityCell.mp sizeToFit];
        [abilityCell.mp setBackgroundColor:[UIColor clearColor]];
        abilityCell.mp.textColor = [UIColor whiteColor];
        [abilityCell.mp setHighlightedTextColor:[UIColor blackColor]];
        [abilityCell addSubview:abilityCell.mp];
    }
    
    if (![ability.cd isEqualToString:@""]) {
        
        [abilityCell.cd removeFromSuperview];
        [abilityCell.cdIcon removeFromSuperview];
        
        abilityCell.cdIcon = [[UIImageView alloc] init];
    
        abilityCell.cdIcon.image = [UIImage imageNamed:@"cooldown.png"];
        abilityCell.cdIcon.frame = CGRectMake(300, yOrigin,25,25);
        [abilityCell addSubview:abilityCell.cdIcon];
        
        abilityCell.cd = [[UILabel alloc] init];
        abilityCell.cd.text = ability.cd;
        abilityCell.cd.frame = CGRectMake(330, yOrigin, 400,40);
        [abilityCell.cd sizeToFit];
        [abilityCell.cd setBackgroundColor:[UIColor clearColor]];
        abilityCell.cd.textColor = [UIColor whiteColor];
        [abilityCell.cd setHighlightedTextColor:[UIColor blackColor]];
        [abilityCell addSubview:abilityCell.cd];
    }
    
    [abilityCell isPassive:[ability.isPassive boolValue]];
    

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