//
//  ItemsTableViewController.m
//  Dota2App
//
//  Created by Jamie O'Hara on 26/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemsTableViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "Item+DAO.h"
#import "ItemsDetailViewController.h"
#import "ItemCell.h"

@interface ItemsTableViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ItemsTableViewController

@synthesize detailViewController = _detailViewController;
@synthesize searchBar;

#pragma mark - Boiler Plate View Code

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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:appDelegate action:@selector(showWelcomePager) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstLoad = YES;
    fetchItem = @"Item";
    AppDelegate * del = [[UIApplication sharedApplication] delegate];
    managedObjectContext = del.managedObjectContext;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //Set item detail nav stack from storyboard id
        del.itemNavStack = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemNav"];
        //Assign to local array for easy access
        itemNavStack = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0], del.itemNavStack, nil];
        //Change splitViewControllers detail nav using this
        self.splitViewController.viewControllers = itemNavStack;
            
        // Do any additional setup after loading the view, typically from a nib.
        self.detailViewController = (ItemsDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    }

    self.tableView.scrollsToTop = YES;
    
    [self configureView];
}



- (void)navigationBarSingleTap:(UIGestureRecognizer*)recognizer {
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
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
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.splitViewController.viewControllers = itemNavStack;
    }
    //Select first hero automatically once view is configured
    if (firstLoad && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        if ([self.tableView.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
            [self.tableView.delegate tableView:self.tableView willSelectRowAtIndexPath:indexPath];
        }
        
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition: UITableViewScrollPositionNone];
        
        if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        }
        
        firstLoad = NO;
    }
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
    return 62;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    ItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Item *selectedItem = [fetchedRC objectAtIndexPath:indexPath];
        ItemsDetailViewController *detailVC = (ItemsDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
        [detailVC setItem:selectedItem];
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

- (void)configureCell:(ItemCell *)cell atIndexPath:(NSIndexPath *)indexPath
{   //Fetch the hero

    Item *item = [fetchedRC objectAtIndexPath:indexPath];
    //Fetch the hero data
    //Configure the cell
    cell.cellTitleLabel.text= item.name;
    cell.cellDetailLabel.text = [item.cost stringValue];
    //cell.cellImage.image = [UIImage imageNamed:item.imgName];
    cell.cellImage.image = [UIImage imageWithContentsOfFile:item.img_path];
    
    cell.cellImage.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.cellImage.layer.shadowOffset = CGSizeMake(2, 2);
    cell.cellImage.layer.shadowOpacity = 1;
    cell.cellImage.layer.shadowRadius = 5.0;
    cell.cellImage.clipsToBounds = NO;
    
    
    UIView *sbview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = sbview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:117/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:41/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0].CGColor, nil];
    [sbview.layer insertSublayer:gradient atIndex:0];
    
    cell.selectedBackgroundView = sbview;
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

- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor2, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // nil for section name key path means "1 section".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    return aFetchedResultsController;
    
}

#pragma mark - Search Bar

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {

    [self filterContentForSearchText:searchText scope:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}


#pragma mark - Screen Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ItemDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Item *selectedItem = [fetchedRC objectAtIndexPath:indexPath];
        ItemsDetailViewController *detailVC = (ItemsDetailViewController *)[segue destinationViewController];
        [detailVC setItem:selectedItem];

    }
}

@end
