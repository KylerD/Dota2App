//
//  DetailViewController.h
//  Dota2App
//
//  Created by Jamie O'Hara on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class ExtendedDetailViewController;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, NSFetchedResultsControllerDelegate> {
    UITableView *detailTableView;
    BOOL freshData;
}

@property (strong, nonatomic) NSString* detailItem;
@property (nonatomic, retain) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSString *savedSearchTerm;

- (NSFetchedResultsController *)fetchedResultsControllerWithDetailItem: (NSString *)detailItem;
@end
