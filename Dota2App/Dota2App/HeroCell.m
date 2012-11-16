//
//  HeroCell.m
//  Dota2App
//
//  Created by Jamie O'Hara on 11/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeroCell.h"

@implementation HeroCell
@synthesize cellTitleLabel, cellDetailLabel, cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
