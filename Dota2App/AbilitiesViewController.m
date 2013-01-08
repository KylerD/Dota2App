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
#import <QuartzCore/QuartzCore.h>

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
    fetchItem = @"Ability";
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    managedObjectContext = del.managedObjectContext;
    
    
    fetchedRC = [self fetchedResultsControllerForEntity: fetchItem];
    if (managedObjectContext) {
        NSError *error = nil;
        if (![fetchedRC performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
        [self.tableView reloadData];
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedRC sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Ability *ability = [fetchedRC objectAtIndexPath:indexPath];
    
    int manaCoolDownHeight = 0;
    
    if (![ability.mc isEqualToString:@""]) {
        manaCoolDownHeight = 30;
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
    
    Ability *ability = [fetchedRC objectAtIndexPath:indexPath];
    
    abilityCell.abilityName.text = ability.name;
    
    abilityCell.lore.text = ability.notes;
    abilityCell.lore.lineBreakMode = UILineBreakModeWordWrap;
    abilityCell.lore.numberOfLines = 0;
    [abilityCell.lore sizeToFit];

    abilityCell.icon.image = [UIImage imageWithContentsOfFile:ability.imagePath];

    int yOrigin = abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + 20;
    
    if (yOrigin <100) {
        yOrigin = 100;
    }
    
    if (![ability.mc isEqualToString:@""]) {
       
        UIImageView * manaCostImage = [[UIImageView alloc] init];
        manaCostImage.image = [UIImage imageNamed:@"manaCost.png"];
        manaCostImage.frame = CGRectMake(50, yOrigin,25,25);
        [abilityCell addSubview:manaCostImage];
        
        UILabel * manaCostLabel = [[UILabel alloc] init];
        manaCostLabel.text = ability.mc;
        manaCostLabel.frame = CGRectMake(80, yOrigin, 400,40);
        [manaCostLabel sizeToFit];
        [manaCostLabel setBackgroundColor:[UIColor clearColor]];
        manaCostLabel.textColor = [UIColor whiteColor];
        [manaCostLabel setHighlightedTextColor:[UIColor blackColor]];
        [abilityCell addSubview:manaCostLabel];
    }
    
    if (![ability.cd isEqualToString:@""]) {

        UIImageView * cooldownImage = [[UIImageView alloc] init];
        cooldownImage.image = [UIImage imageNamed:@"cooldown.png"];
        cooldownImage.frame = CGRectMake(300, yOrigin,25,25);
        [abilityCell addSubview:cooldownImage];
        
        UILabel * cooldownLabel= [[UILabel alloc] init];
        cooldownLabel.text = ability.cd;
        cooldownLabel.frame = CGRectMake(330, yOrigin, 400,40);
        [cooldownLabel sizeToFit];
        [cooldownLabel setBackgroundColor:[UIColor clearColor]];
        cooldownLabel.textColor = [UIColor whiteColor];
        [cooldownLabel setHighlightedTextColor:[UIColor blackColor]];
        [abilityCell addSubview:cooldownLabel];
    }
    
    [abilityCell isPassive:[ability.isPassive boolValue]];
    
    CGFloat abilityCellHeight = [self tableView:self.tableView heightForRowAtIndexPath:indexPath];

//tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    
    UIView *sbview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, abilityCell.frame.size.width, abilityCellHeight)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = sbview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:117/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:41/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0].CGColor, nil];
    [sbview.layer insertSublayer:gradient atIndex:0];
    
    abilityCell.selectedBackgroundView = sbview;

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AbilityDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Ability *selectedAbility = [fetchedRC objectAtIndexPath:indexPath];
      AbilityDetailViewController *abilityDetailVC = (AbilityDetailViewController *)[segue destinationViewController];
      [abilityDetailVC setAbility:selectedAbility];

    }
}

#pragma mark - NSFetchedRC Delegate

- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"hero = %@",self.hero];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setPredicate:pred];
    
    // nil for section name key path means "1 section".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    return aFetchedResultsController;
    
}



- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


@end