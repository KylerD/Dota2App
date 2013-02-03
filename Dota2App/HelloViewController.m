//
//  HelloViewController.m
//  Dota2App
//
//  Created by Luke McNeice on 13/01/2013.
//
//

#import "HelloViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "Socialize/SZTwitterUtils.h"
//#import "Socialize/SZFacebookUtils.h"


@interface HelloViewController ()

@end

@implementation HelloViewController

@synthesize backgroundImage,welcomePanel,sharePanel,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (CGRect)getScreenFrameForCurrentOrientation {
    return [self getScreenFrameForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect fullScreenRect = screen.bounds;
    BOOL statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    
    //implicitly in Portrait orientation.
    if(orientation == UIInterfaceOrientationLandscapeRight || orientation ==  UIInterfaceOrientationLandscapeLeft){
        CGRect temp = CGRectZero;
        temp.size.width = fullScreenRect.size.height;
        temp.size.height = fullScreenRect.size.width;
        fullScreenRect = temp;
    }
    
    if(!statusBarHidden){
        CGFloat statusBarHeight = 20;
        fullScreenRect.size.height -= statusBarHeight;
    }
    
    return fullScreenRect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.welcomePanel.center = self.view.center;

}

- (IBAction)close:(id)sender{
    [self.delegate dismissModalFromParent];
}

- (IBAction)share:(id)sender{
    
    [self postToTwitter];
}

- (void)postToTwitter {
    NSString *text = @"Test";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:text forKey:@"status"];
    
//    [SZTwitterUtils postWithViewController:self path:@"/1/statuses/update.json" params:params success:^(id result) {
//        NSLog(@"Posted to Twitter feed: %@", result);
//        
//    } failure:^(NSError *error) {
//        NSLog(@"Failed to post to Twitter feed: %@ / %@", [error localizedDescription], [error userInfo]);
//    }];
    
    NSMutableDictionary *postData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"hi there", @"message",
                                     nil];
    
//    
//    [SZFacebookUtils postWithGraphPath:@"me/feed" params:postData success:^(id result) {
//        NSLog(@"Posted to fb feed: %@", result);
//        
//    }  failure:^(NSError *error) {
//        NSLog(@"Failed to post to fb feed: %@ / %@", [error localizedDescription], [error userInfo]);
//    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
