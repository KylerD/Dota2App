//
//  InformationViewController.h
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import <UIKit/UIKit.h>
#import "Hero.h"
@interface InformationViewController : UIViewController  {
    NSArray * heroStatsRowItemArray;

}

@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *primaryAttributeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *factionImageView;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@property (weak, nonatomic) IBOutlet UILabel *strengthPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *agilityPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *intelligencePointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *damagePointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *movementSpeedPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *armorPointsLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@property (weak, nonatomic) IBOutlet UILabel *turnRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sightRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *missileSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *castDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *hitPointsLevelOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *manaLevelOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *damageLevelOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *armorLevelOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackSpeedLevelOneLabel;
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, strong) Hero *hero;


- (void)configureView;


@end
