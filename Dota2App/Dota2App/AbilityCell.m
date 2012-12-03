//
//  AbilityCell.m
//  Dota2App
//
//  Created by Kyle Davidson on 03/12/2012.
//
//

#import "AbilityCell.h"

@implementation AbilityCell
@synthesize cellImageView, cellTitleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
