//
//  ItemCell.m
//  Dota2App
//
//  Created by Stuart McKee on 29/12/2012.
//
//

#import "ItemCell.h"

@implementation ItemCell
@synthesize cellTitleLabel, cellDetailLabel, cellImage;

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

    // Configure the view for the selected state
}

@end
