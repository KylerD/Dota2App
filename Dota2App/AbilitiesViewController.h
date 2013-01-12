//
//  AbilitiesViewController.h
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import <UIKit/UIKit.h>
#import "Hero.h"

@interface AbilitiesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedRC;
    NSString *fetchItem;
    UITableView *tableView;
    NSArray *abilities;
        int cellHeight;
}

@property (nonatomic, strong) Hero *hero;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
/* Creates a fetched results controller based on the entity name based in 
 @param entityName: the name of the entity to be used by the fetch request */
- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString *)entityName;

@end
