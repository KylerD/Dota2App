//
//  DetailViewController.h
//  Dota2App
//
//  Created by Jamie O'Hara on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hero.h"
@class ExtendedDetailViewController;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,NSFetchedResultsControllerDelegate> {
    UIImageView *iconImageView;
    UIImageView *detailImageView;
    BOOL freshData;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@property (nonatomic, retain) IBOutlet UIImageView *detailImageView;
@property (nonatomic, retain) Hero *hero;

@end
