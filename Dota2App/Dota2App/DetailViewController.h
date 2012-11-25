//
//  DetailViewController.h
//  Dota2App
//
//  Created by  Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hero.h"
#import "AbilitiesViewController.h"

@class ExtendedDetailViewController;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,NSFetchedResultsControllerDelegate> {
    UIImageView *iconImageView;
    UIImageView *detailImageView;
    UIViewController *currentVC;

}

@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@property (nonatomic, retain) Hero *hero;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segment;

/*
 * Displays a view controller based on the segment selected
 * @return the view controller to be displayed
 * @param the segment selected
 */
- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index;


@end
