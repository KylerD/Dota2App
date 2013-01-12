//
//  ItemsTableViewController.h
//  Dota2App
//
//  Created by Jamie O'Hara on 26/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Item.h"

@class ItemsDetailViewController;

@interface ItemsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate> {

    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedRC;
    NSString *fetchItem;
    NSString *savedSearchTerm;
    NSArray *itemNavStack;
    BOOL freshData;
}

@property (strong, nonatomic) ItemsDetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

/* Creates a fetched results controller based on the entity name based in 
 @param entityName: the name of the entity to be used by the fetch request */
- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName;

@end
