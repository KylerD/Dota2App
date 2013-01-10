//
//  AbilityVideoViewController.h
//  Dota2App
//
//  Created by Stuart McKee on 10/01/2013.
//
//

#import <UIKit/UIKit.h>
#import "Ability.h"

@interface AbilityVideoViewController : UIViewController

@property (nonatomic,retain)IBOutlet UIWebView * abilityVideo;

@property (nonatomic, retain)Ability * ability;
@end
