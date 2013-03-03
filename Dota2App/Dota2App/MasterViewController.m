//
//  MasterViewController.m
//  Dota2App
//
//  Created by  Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "HeroCell.h"
#import "Hero.h"
#import "Role.h"
#import "PagedWelcome.h"
#import "NSManagedObject+CRUD.h"
#import "StackMob.h"


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
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:appDelegate action:@selector(showWelcomePager) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
    }
}



-(NSFetchRequest*)fetchedRequestForEntity:(NSString*)entityName{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"primary_attribute" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor2, sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return fetchRequest;
    
}

- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName {
    
    // nil for section name key path means "1 section".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchedRequestForEntity:entityName] managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    return aFetchedResultsController;
    
}

#pragma mark - View lifecycle

-(void)userRefresh{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    //[self.tableView data]
    //[del.coreDataStore resetCache];
    //[self getAndDisplayHeros];
}


-(void)performFetchWithRC{
    
    if(!fetchedRC){
        fetchedRC = [self fetchedResultsControllerForEntity:@"Hero"];
    }
    
    NSError *error = nil;
    if (![fetchedRC performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    } else{
        NSLog(@"Fetch complete");
    }
    
     searchBar.hidden = NO;
    [self.tableView reloadData];
    
}

//-(void)prefetchHeroes{
//
//    NSFetchRequest * allHeroesRequest = [self fetchedRequestForEntity:fetchItem];
//
//    //NSUInteger count = [managedObjectContext countForFetchRequest:allHeroesRequest error:nil];
//        [managedObjectContext executeFetchRequest:allHeroesRequest onSuccess:^(NSArray* a){
//        } onFailure:^(NSError*e){
//        }];
//
//}

-(void)getAndDisplayHeros{
    [self.refreshControl beginRefreshing];
    searchBar.hidden = YES;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        
        //NSFetchRequest * allHeroesRequest = [self fetchedRequestForEntity:fetchItem];
        
        //[managedObjectContext executeFetchRequest:allHeroesRequest onSuccess:^(NSArray* a){
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                           ^{
                               [self performSelector:@selector(performFetchWithRC)];
                               
                               dispatch_async(dispatch_get_main_queue(),
                                              ^{
                                                  [self.tableView reloadData];
                                                  [self.refreshControl endRefreshing];
                                                  searchBar.hidden = NO;
                                              });
                           });
            
            
            
//        } onFailure:^(NSError*e){
//            [self.refreshControl endRefreshing];
//        }];
    
        
    //});
}

-(void)heroFetchComplete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                   ^{
                       [self performSelector:@selector(performFetchWithRC)];
                       
                       dispatch_async(dispatch_get_main_queue(),
                                      ^{
                                          [self.tableView reloadData];
                                          [self.refreshControl endRefreshing];
                                          searchBar.hidden = NO;
                                      });
                   });
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heroFetchComplete) name:@"HeroFetchComplete" object:nil];
    
    firstLoad = YES;
    
    //PREFETCHING HEROES...
    fetchItem = @"Hero";
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [del.coreDataStore contextForCurrentThread];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    //refreshControl.tintColor = [UIColor colorWithRed:117/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(userRefresh) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Getting Heroes.."];
    self.refreshControl = refreshControl;
    //[self getAndDisplayHeros];
    
    //- (void)saveOnSuccess:(SMSuccessBlock)successBlock onFailure:(SMFailureBlock)failureBlock;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        heroNavStack = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0], del.heroNavStack, nil];
    }
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.tableView.scrollsToTop = YES;
    
    [self configureView];
    
}



- (void)navigationBarSingleTap:(UIGestureRecognizer*)recognizer {
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        self.splitViewController.viewControllers = heroNavStack;
    }
    self.tableView.scrollsToTop = YES;
    //Select first hero automatically once view is configured (only in landscape/ipad)
    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    if (firstLoad && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && UIDeviceOrientationIsLandscape(interfaceOrientation)) {
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
    static NSString *CellIdentifier = @"HeroCell";
    HeroCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        Hero *selectedHero = [fetchedRC objectAtIndexPath:indexPath];
        [self.detailViewController setHero:selectedHero];
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
    NSMutableString *subtitle = [NSMutableString string];
    //subtitle = [NSString stringWithFormat:@"%@ - %@", hero.faction, hero.primaryAttribute];
    
    
    for (Role * r in hero.roles) {
        [subtitle appendFormat:@"%@ - ",r.role_name];
        
    }
    
    if(![subtitle isEqualToString:@""]){
        [subtitle deleteCharactersInRange:NSMakeRange(subtitle.length-3,3)];
    }
    
    NSString *factionImageName = [NSString stringWithFormat:@"%@.png", hero.faction];
    NSString *attributeImageName = [NSString stringWithFormat:@"%@.png", hero.primary_attribute];
    //Configure the cell
    heroCell.cellTitleLabel.text = hero.name;
    heroCell.cellDetailLabel.text = subtitle;
    //TODO: ICON IMAGE URL
    heroCell.cellImage.image = [UIImage imageNamed:hero.icon_image];
    
    //    heroCell.cellImage.layer.borderColor = [UIColor colorWithRed:0.89 green:0.69 blue:0.25 alpha:1.0].CGColor;//89,68,25
    //    heroCell.cellImage.layer.borderWidth = 1.0f;
    
    UIView *sbview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, heroCell.frame.size.width, heroCell.frame.size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = sbview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:117/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:41/ 255.0 green:0/ 255.0 blue:2/ 255.0 alpha:1.0].CGColor, nil];
    [sbview.layer insertSublayer:gradient atIndex:0];
    
    heroCell.selectedBackgroundView = sbview;
    
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
    [self.refreshControl endRefreshing];
}

#pragma mark - Search bar

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (![searchText isEqualToString:@""]) {
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"(name contains[cd] %@) OR (ANY nicknames.name contains[cd] %@) OR (ANY roles.role_name contains[cd] %@)", searchText,searchText,searchText];
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

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    [self filterContentForSearchText:searchText scope:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Screen Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Hero *selectedHero = [fetchedRC objectAtIndexPath:indexPath];
        DetailViewController *detailVC = (DetailViewController *)[segue destinationViewController];
        [detailVC setHero:selectedHero];
    }
}


@end
