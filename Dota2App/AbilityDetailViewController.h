//
//  AbilityDetailViewController.h
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import <UIKit/UIKit.h>
#import "Ability+DAO.h"

@interface AbilityDetailViewController : UIViewController {

}

@property (nonatomic, retain) Ability *ability;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *mcLabel;
@property (nonatomic, strong) IBOutlet UILabel *cdLabel;
@property (nonatomic, strong) IBOutlet UIWebView *videoWebView;
@property (nonatomic, strong) IBOutlet UIImageView *abilityImage;
@property (nonatomic, strong) IBOutlet UIImageView *mcIcon;
@property (nonatomic, strong) IBOutlet UIImageView *cdIcon;
@property (nonatomic, strong) IBOutlet UIScrollView *view;


- (void)makeiPhoneGridWithDictionary: (NSDictionary*)dictionary;
- (void)makeiPadGridWithDictionary: (NSDictionary*)dictionary;

-(void)configureView;
@end
