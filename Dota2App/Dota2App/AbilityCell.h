//
//  AbilityCell.h
//  Dota2App
//
//  Created by Kyle Davidson on 03/12/2012.
//
//

#import <UIKit/UIKit.h>

@interface AbilityCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * abilityName;
@property (nonatomic, strong) IBOutlet UIImageView *icon;
@property (nonatomic, strong) IBOutlet UILabel * mp;
@property (nonatomic, strong) IBOutlet UIImageView *mpIcon;
@property (nonatomic, strong) IBOutlet UILabel * cd;
@property (nonatomic, strong) IBOutlet UIImageView *cdIcon;
@property (nonatomic, strong) IBOutlet UILabel * isPassiveLabel;

- (void)isPassive:(BOOL)isPassive;

@end
