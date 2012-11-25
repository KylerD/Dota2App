//
//  MasterViewController.m
//  Dota2App
//
//  Created by  Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "HeroCell.h"
#import "Hero.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View Setup
- (void)configureView
{    
    fetchedRC = [self fetchedResultsControllerForEntity: fetchItem];
    if (managedObjectContext) {
        NSError *error = nil;
        if (![fetchedRC performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
        [self.tableView reloadData];
    }
}

- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];

    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"primaryAttribute" ascending:YES selector:@selector(caseInsensitiveCompare:)];

    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"faction" ascending:NO selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, sortDescriptor3, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];

    // nil for section name key path means "1 section".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"primaryAttribute" cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    return aFetchedResultsController;

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    fetchItem = @"Hero";
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    managedObjectContext = del.managedObjectContext;
    [self configureView];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[fetchedRC sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedRC sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeroCell";
    HeroCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        Hero *selectedHero = [fetchedRC objectAtIndexPath:indexPath];
        self.detailViewController.hero= selectedHero;
    } 
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedRC sections] objectAtIndex:section];

    return [sectionInfo name];
}

-(NSString *)controller:(NSFetchedResultsController *)controller
    sectionIndexTitleForSectionName:(NSString *)sectionName {
    return sectionName;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{   //Fetch the hero
    HeroCell *heroCell = (HeroCell *)cell;
    Hero *hero = [fetchedRC objectAtIndexPath:indexPath];
    //Fetch the hero data
    NSString *subtitle = [NSString stringWithFormat:@"%@ - %@", hero.faction, hero.primaryAttribute];
    NSString *factionImageName = [NSString stringWithFormat:@"%@.png", hero.faction];
    NSString *attributeImageName = [NSString stringWithFormat:@"%@.png", hero.primaryAttribute];
    //Configure the cell
    heroCell.cellTitleLabel.text = hero.name;
    heroCell.cellDetailLabel.text = subtitle;
    heroCell.cellImage.image = [UIImage imageNamed:hero.iconImage];
    heroCell.cellImage.contentMode = UIViewContentModeScaleAspectFit;
    heroCell.factionImage.image = [UIImage imageNamed:factionImageName];
    heroCell.attributeImage.image = [UIImage imageNamed:attributeImageName];
}

#pragma mark - NSFetchedRC Delegate

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
    UITableView *tableView = self.tableView;
    
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

#pragma mark - Search bar

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{   
    savedSearchTerm = searchText;
    
    freshData = NO;
    
    if (![searchText isEqualToString:@""]) {
        
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
        [fetchedRC.fetchRequest setPredicate:predicate];
        
    } else {
        [fetchedRC.fetchRequest setPredicate:nil];
    }
    
    NSError *error = nil;
    if (![fetchedRC performFetch:&error]) {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    [self.tableView reloadData];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{   
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:nil];
    
    return YES;
}

#pragma mark - Screen Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Hero *selectedHero = [fetchedRC objectAtIndexPath:indexPath];
        [[segue destinationViewController] setHero:selectedHero];
    }
}


@end
