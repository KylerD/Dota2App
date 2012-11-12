//
//  ExtendedDetailViewController.h
//  Dota2App
//
//  Created by Stuart on 12/11/2012.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hero.h"
@interface ExtendedDetailViewController : UIViewController <UISplitViewControllerDelegate>



@property (strong, nonatomic) Hero* detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *heroPortrait;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
