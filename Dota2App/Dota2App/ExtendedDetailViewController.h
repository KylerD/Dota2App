//
//  ExtendedDetailViewController.h
//  Dota2App
//
//  Created by Stuart on 12/11/2012.
//
//

#import <UIKit/UIKit.h>
#import "Hero.h"
@interface ExtendedDetailViewController : UIViewController <UISplitViewControllerDelegate>



@property (nonatomic, retain) Hero* detailItem;
@property (nonatomic, retain) IBOutlet UIImageView *heroPortrait;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
