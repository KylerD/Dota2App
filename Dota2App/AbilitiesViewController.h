//
//  AbilitiesViewController.h
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import <UIKit/UIKit.h>
#import "Hero.h"

@interface AbilitiesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *tableView;
    
}

@property (nonatomic, strong) Hero *hero;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
