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


#define CELL_PADDING_HEIGHT 70
#define CELL_MINIMUM_HEIGHT_IPAD 110
#define CELL_PADDING_LORE_IPAD 111
#define CELL_MINIMUM_HEIGHT_IPHONE 90
#define CELL_MANACOOLDOWN_ADD 40

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int calculatedHeight = 0;
    
    Ability *ability = [fetchedRC objectAtIndexPath:indexPath];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){//IPHONE
        calculatedHeight = CELL_MINIMUM_HEIGHT_IPHONE;
    } else { //IPAD
        
        //TEXT CALCULATION
        if(![ability.notes isEqualToString:@""]){
            
            NSString *text = ability.notes;
            CGSize constraint = CGSizeMake(self.view.frame.size.width - (CELL_PADDING_LORE_IPAD * 2),FLT_MAX);
            CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:constraint];
            
            calculatedHeight += (textSize.height + CELL_PADDING_HEIGHT);
            
        }
        
        //MANA AND COOLDOWN CALCULATION
        if(![ability.mc isEqualToString:@""] || ![ability.cd isEqualToString:@""]){
            calculatedHeight += CELL_MANACOOLDOWN_ADD;
        }
        
        //Ensuring a Minimum
        if(calculatedHeight<CELL_MINIMUM_HEIGHT_IPAD) {
            calculatedHeight = CELL_MINIMUM_HEIGHT_IPAD;
        }
    }

    return calculatedHeight;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AbilityCell";
    AbilityCell *cell = (AbilityCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AbilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(NSString *)controller:(NSFetchedResultsController *)controller
sectionIndexTitleForSectionName:(NSString *)sectionName {
    return sectionName;
}


#define CELL_MANACOOLDOWN_PADDING 20
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
    
    abilityCell.icon.layer.shadowColor = [UIColor blackColor].CGColor;
    abilityCell.icon.layer.shadowOffset = CGSizeMake(2, 2);
    abilityCell.icon.layer.shadowOpacity = 1;
    abilityCell.icon.layer.shadowRadius = 5.0;
    abilityCell.icon.clipsToBounds = NO;
    
    int yOrigin = abilityCell.lore.frame.origin.y + abilityCell.lore.frame.size.height + CELL_MANACOOLDOWN_PADDING;
    if (yOrigin <100) {
        yOrigin = 100;
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
        abilityCell.mp.text = ability.mc;
        abilityCell.cd.text = ability.cd;
    }
    else{
        //This is a mess...and asking for trouble...
        if (![ability.mc isEqualToString:@""]) {
            [abilityCell.mpIcon removeFromSuperview];
            [abilityCell.mp removeFromSuperview];
            abilityCell.mpIcon = [[UIImageView alloc] init];
            abilityCell.mpIcon.image = [UIImage imageNamed:@"manaCost.png"];
            abilityCell.mpIcon.frame = CGRectMake(111, yOrigin,25,25);//50
            [abilityCell addSubview:abilityCell.mpIcon];
            
            abilityCell.mp = [[UILabel alloc] init];
            abilityCell.mp.text = ability.mc;
            abilityCell.mp.frame = CGRectMake(151, yOrigin, 400,40);//80
            [abilityCell.mp sizeToFit];
            [abilityCell.mp setBackgroundColor:[UIColor clearColor]];
            abilityCell.mp.textColor = [UIColor whiteColor];
            [abilityCell.mp setHighlightedTextColor:[UIColor blackColor]];
            [abilityCell addSubview:abilityCell.mp];
        }
        
        if (![ability.cd isEqualToString:@""]) {
            [abilityCell.cdIcon removeFromSuperview];
            [abilityCell.cd removeFromSuperview];
            abilityCell.cdIcon = [[UIImageView alloc] init];
            abilityCell.cdIcon.image = [UIImage imageNamed:@"cooldown.png"];
            abilityCell.cdIcon.frame = CGRectMake(361, yOrigin,25,25);//300
            [abilityCell addSubview:abilityCell.cdIcon];
            
            abilityCell.cd= [[UILabel alloc] init];
            abilityCell.cd.text = ability.cd;
            abilityCell.cd.frame = CGRectMake(401, yOrigin, 400,40);//330
            [abilityCell.cd sizeToFit];
            [abilityCell.cd setBackgroundColor:[UIColor clearColor]];
            abilityCell.cd.textColor = [UIColor whiteColor];
            [abilityCell.cd setHighlightedTextColor:[UIColor blackColor]];
            [abilityCell addSubview:abilityCell.cd];
        }
    }
    [abilityCell isPassive:[ability.isPassive boolValue]];
    

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
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


@end