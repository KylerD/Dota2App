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

#pragma mark - View
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [abilities count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
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
    
    abilityCell.cellTitleLabel.text = ability.name;
    
    //custom code for images for now
    NSString *imageName = [NSString stringWithFormat:@"%@.png", ability.name];
    abilityCell.cellImageView.image = [UIImage imageNamed:imageName];
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