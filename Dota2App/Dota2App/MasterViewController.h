//
//  MasterViewController.h
//  Dota2App
//
//  Created by Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    NSManagedObjectContext *managedObjectContext;
    NSArray *heroNavStack;
    NSFetchedResultsController *fetchedRC;
    NSString *fetchItem;
}

@property (strong, nonatomic) DetailViewController *detailViewController;


/*
 * Fetches a results controller for an entity of entityName
 * @return The results controller
 * @param the entityName
 *
 */
- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName;

@end
