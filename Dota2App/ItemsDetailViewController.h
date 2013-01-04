//
//  ItemsDetailViewController.h
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import <UIKit/UIKit.h>
#import "Item+DAO.h"

@interface ItemsDetailViewController : UIViewController

@property (nonatomic, strong) Item *item;
@property (nonatomic, retain) IBOutlet UILabel * cost;
@property (nonatomic, retain) IBOutlet UILabel * name;
@property (nonatomic, retain) IBOutlet UILabel * description;
@property (nonatomic, retain) IBOutlet UILabel * lore;
@property (nonatomic, retain) IBOutlet UILabel * manaCost;
@property (nonatomic, retain) IBOutlet UILabel * cooldown;


@property (nonatomic, retain) IBOutlet UIImageView * image;
@property (nonatomic, retain) IBOutlet UIImageView * manaImage;
@property (nonatomic, retain) IBOutlet UIImageView * cooldownImage;
@end
