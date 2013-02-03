//
//  ShareViewController.m
//  Dota2App
//
//  Created by Luke McNeice on 02/02/2013.
//
//

#import "ShareViewController.h"
#import "SHK.h"

@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize context,shareButton,shareMessage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

#define twitterMessage @"Just testing the share feature this awesome DOTA2 Clarity app #Clarity #DOTA2 http://imgur.com/a/Dbdtd#0"

- (void)viewDidLoad
{
    [super viewDidLoad];
        
        CGRect screenRect = [self getScreenFrameForCurrentOrientation];
        
        CGRect viewFrame = self.view.frame;
        
        viewFrame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y, screenRect.size.width, 180);
    self.view.frame = viewFrame;
    
    
    if([self.context isEqualToString:@"twitter"]){
        self.shareMessage.text = twitterMessage;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)share:(id)sender{
    NSLog(@"Sharing for context: %@",self.context);
    [self shareWithContext:self.context];
}


- (void)shareWithContext:(NSString*)ctx{
    
    if([ctx  isEqualToString:@"twitter"]){
        //Check userdefaults for existing tokens...
        NSString * existingAccessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"DOTA2TwitterAccessToken"];
        
        NSString * existingSecret = [[NSUserDefaults standardUserDefaults] valueForKey:@"DOTA2TwitterSecret"];
        
//        [SZTwitterUtils linkWithAccessToken:existingAccessToken accessTokenSecret:existingSecret success:^(id<SocializeFullUser> user) {
//            NSLog(@"Link Complete");
//        } failure:^(NSError *error) {
//            NSLog(@"Link failure: %@", [error localizedDescription]);
//        }];
        
        [self postToTwitter:self.shareMessage.text];
    }     
}

- (void)postToTwitter:(NSString*)body {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:body forKey:@"status"];
    
//    [SZTwitterUtils postWithViewController:self path:@"/1/statuses/update.json" params:params success:^(id result) {
//        NSLog(@"Posted to Twitter feed: %@", result);
//        
//    } failure:^(NSError *error) {
//        NSLog(@"Failed to post to Twitter feed: %@ / %@", [error localizedDescription], [error userInfo]);
//    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
