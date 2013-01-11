//
//  GuidesViewController.h
//  Dota2App
//
//  Created by Luke McNeice on 11/01/2013.
//
//

#import <UIKit/UIKit.h>

#define STEAM_DOTA_GUIDES_URL @"http://steamcommunity.com/app/570/guides/?browsefilter=toprated&requiredtags%5B0%5D=Characters&browsesort=toprated&p=1"

@interface GuidesViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
