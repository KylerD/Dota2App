//
//  ItemCell.h
//  Dota2App
//
//  Created by Stuart McKee on 29/12/2012.
//
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *cellTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *cellDetailLabel;
@property (nonatomic, retain) IBOutlet UIImageView *cellImage;
@end
