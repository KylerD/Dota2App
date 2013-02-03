//
//  UpdatesViewController
//  Dota2App
//
//  Created by Luke McNeice on 13/01/2013.
//
//

#import "UpdatesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShareViewController.h"
#import "JWFolders.h"

@interface UpdatesViewController (){
    JWFolders *folder;
}

- (CGRect)getScreenFrameForCurrentOrientation;
- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;

@end

@implementation UpdatesViewController

@synthesize backgroundImage,messagePanel,delegate,scrollView,contentView,isSplit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.messagePanel.layer.cornerRadius = 8;
    self.messagePanel.layer.masksToBounds = YES;
    CGSize frameSize = self.contentView.frame.size;
    self.scrollView.contentSize = CGSizeMake(frameSize.width, frameSize.height+100);
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
}

- (void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self];//UIDeviceOrientationDidChangeNotification
}

//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    [scrollView setContentOffset:CGPointMake(0, 320) animated:YES];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView{
//     [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//}

- (IBAction)close:(id)sender{
    [self.delegate dismissModalFromParent];
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

#define shareViewiPhoneNibName @"ShareViewiPhone"
#define shareViewiPadNibName @"ShareViewipad"


- (ShareViewController*)shareSubmitViewController{
    
    
    ShareViewController * shareVC = nil;
    NSString * deviceBasedNibName = nil;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        deviceBasedNibName = [NSString stringWithFormat:shareViewiPadNibName];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        deviceBasedNibName = [NSString stringWithFormat:shareViewiPhoneNibName];
    }
    
    shareVC = [[ShareViewController alloc] initWithNibName:deviceBasedNibName bundle:nil];
    
    return shareVC;
 }


- (void)splitFromButton:(UIButton*)button{
    
    [self.delegate stopAutoPaging];
    
    if(self.isSplit){
        [folder closeCurrentFolder];
        return;
    }
    
    folder = [JWFolders folder];
    
    CGPoint senderGlobalPosition = [self.contentView convertPoint:button.center fromView:[button superview]];
    
    folder.containerView = self.contentView;
    
    ShareViewController * shareVC = [self shareSubmitViewController];
    folder.contentView = shareVC.view;
    folder.contentView.backgroundColor = [UIColor redColor];
    folder.position = CGPointMake(senderGlobalPosition.x,senderGlobalPosition.y - (button.frame.size.height/2) - 15);
    folder.direction = JWFoldersOpenDirectionUp;
    folder.contentBackgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    folder.shadowsEnabled = YES;
    folder.showsNotch = YES;
    [folder open]; // opens the folder.
    
    [folder setOpenBlock:^(UIView *contentView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
        self.isSplit=YES;
    }];
    

    [folder setCloseBlock:^(UIView *contentView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
        self.isSplit=NO;
    }];

}

-(void)orientationChanged:(id)sender{
    [folder closeCurrentFolder];
}

- (IBAction)facebook:(id)sender{
    //[self animateForShareButton:sender];
    [self splitFromButton:(UIButton*)sender];
}
- (IBAction)twitter:(id)sender{
    [self splitFromButton:(UIButton*)sender];
}
- (IBAction)google:(id)sender{
    [self splitFromButton:(UIButton*)sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
