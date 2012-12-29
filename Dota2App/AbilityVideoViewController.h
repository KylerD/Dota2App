//
//  AbilityVideoViewController.h
//  Dota2App
//
//  Created by Luke McNeice on 29/12/2012.
//
//

#import <UIKit/UIKit.h>

#import "YouTubeView.h"

@interface AbilityVideoViewController : UIViewController

@property (nonatomic,strong) YouTubeView * youTubeView;
@property (nonatomic,strong) NSString * url;

@end
