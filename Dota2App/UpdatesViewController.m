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

typedef enum SplitDirection
{
    SplitDirectionUnknown,
    SplitDirectionDown,
    SplitDirectionUp
}SplitDirection;

@interface UpdatesViewController (){
    UIButton * selectedShareButton;
    UIImageView * upperSplit;
    UIImageView * lowerSplit;
    UIView * splitBody;
    JWFolders *folder;
    SplitDirection currentSplitDirection;
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [scrollView setContentOffset:CGPointMake(0, 320) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
     [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

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

#define splitAnimationTime 0.5
#define shareMessage @"Just downloaded this awesome DOTA2 Clarity app #Clarity #DOTA2 http:\\bit.ly\abcdefg"
#define twitterShareMessage shareMessage
#define shareTextFontSize 24
#define shareTextWidthConstraint 320
#define shareTextHeightConstraint 200
#define shareTextPaddingTop 30
#define shareTextPaddingLeft 100
//#define shareTextQuoteHeight 60

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
    
    
//    UIFont * shareTextFont = [UIFont systemFontOfSize:shareTextFontSize];
//    CGSize textFrameCalculation = [shareMessage sizeWithFont:shareTextFont constrainedToSize:CGSizeMake(shareTextWidthConstraint, shareTextHeightConstraint) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    CGRect fullScreenRect = [self getScreenFrameForCurrentOrientation];
//    UIView *revealedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fullScreenRect.size.width, 200)];
//    [revealedView setBackgroundColor:[UIColor redColor]];
//    revealedView.clipsToBounds = YES;
//    
//   
//    
//    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(shareTextPaddingLeft, shareTextPaddingTop, shareTextWidthConstraint, shareTextHeightConstraint - shareTextPaddingTop -10)];
//    [textView setFont:shareTextFont];
//    [textView setTextColor:[UIColor whiteColor]];
//    [textView setEditable:NO];
//    [textView setBackgroundColor:[UIColor clearColor]];
//    [textView setText:twitterShareMessage];
//    
//    
//    textView.delegate = self;
//    
//    UIImage * quoteLeftImg = [UIImage imageNamed:@"quoteleft"];
//    UIImageView * quotesLeft  = [[UIImageView alloc] initWithImage:quoteLeftImg];
//    [quotesLeft setContentMode:UIViewContentModeScaleAspectFit];
//    quotesLeft.frame = CGRectMake(shareTextPaddingLeft - shareTextQuoteHeight,10, shareTextQuoteHeight, shareTextQuoteHeight);
//    
//    UIImage *flippedImage = [[UIImage alloc] initWithCGImage:quoteLeftImg.CGImage scale:0 orientation:UIImageOrientationDown];
//    UIImageView *quotesRight = [[UIImageView alloc] initWithImage:flippedImage];
//    [quotesRight setContentMode:UIViewContentModeScaleAspectFit];
//    //quotesRight.frame = CGRectMake(textView.frame.origin.x+textView.frame.size.width,(textView.frame.origin.y+textView.frame.size.height) -shareTextQuoteHeight +10, shareTextQuoteHeight, shareTextQuoteHeight);
//    quotesRight.frame = CGRectMake(textView.frame.origin.x + 230,(textView.frame.origin.y+textView.frame.size.height) -shareTextQuoteHeight +10, shareTextQuoteHeight, shareTextQuoteHeight);
//    
//    
//    [revealedView addSubview:textView];
//    [revealedView addSubview:quotesLeft];
//    [revealedView addSubview:quotesRight];
//    return revealedView;
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
     
    [self.contentView addSubview:splitBody];    
}

- (void)split:(SplitDirection)splitDirection
 atYPostition:(int)splitYPosition
withRevealedViewHeight:(int)revealedViewHeight{
    
    // wouldn't be sharp on retina displays, instead use "withOptions" and set scale to 0.0
    // UIGraphicsBeginImageContext(self.contentView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.contentView.bounds.size, NO, 0.0);
    [self.contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *f = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect fullScreenRect = [self getScreenFrameForCurrentOrientation];
    
    CGRect upperSplitRect = CGRectMake(0, 0,fullScreenRect.size.width, splitYPosition);
    CGRect lowerSplitRect = CGRectMake(0, splitYPosition, fullScreenRect.size.width, fullScreenRect.size.height-splitYPosition);
    
    
    CGImageRef upperImageRef = CGImageCreateWithImageInRect([f CGImage], upperSplitRect);
    UIImage *upperCroppedImage = [UIImage imageWithCGImage:upperImageRef];
    CGImageRelease(upperImageRef);
    
    CGImageRef lowerImageRef = CGImageCreateWithImageInRect([f CGImage], lowerSplitRect);
    UIImage *lowerCroppedImage = [UIImage imageWithCGImage:lowerImageRef];
    CGImageRelease(lowerImageRef);
    
    
    UIImageView *upperImage = [[UIImageView alloc]initWithFrame:upperSplitRect];
    upperImage.image = upperCroppedImage;
    //first.contentMode = UIViewContentModeTop;
    
    UIView *upperBoarder = [[UIView alloc]initWithFrame:CGRectMake(0, splitYPosition, fullScreenRect.size.width, 1)];
    upperBoarder.backgroundColor = [UIColor whiteColor];
    [upperImage addSubview:upperBoarder];
    
    
    UIImageView *lowerImage = [[UIImageView alloc]initWithFrame:lowerSplitRect];
    lowerImage.image = lowerCroppedImage;
    //second.contentMode = UIViewContentModeBottom;
    
    UIView *lowerBoarder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fullScreenRect.size.width, 1)];
    lowerBoarder.backgroundColor = [UIColor whiteColor];
    [lowerImage addSubview:lowerBoarder];
    
    int reveledViewYPosition = splitYPosition;
    
    if(splitDirection==SplitDirectionUp){
        reveledViewYPosition = splitYPosition - revealedViewHeight;
    }
    
    [UIView animateWithDuration:splitAnimationTime animations:^{
        
        if(splitDirection==SplitDirectionUp){
            upperImage.center = CGPointMake(upperImage.center.x, upperImage.center.y-revealedViewHeight);
        } else { //assume down
            lowerImage.center = CGPointMake(lowerImage.center.x, lowerImage.center.y+revealedViewHeight);
        }
        
    } completion:^(BOOL complete){
        currentSplitDirection = splitDirection;
        
        [self animateFormShow];
    }];
}

#define shareFormPadding 20
- (void)animateFormShow{
    
    CGRect revealedViewFrame = splitBody.frame;
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(shareFormPadding,shareFormPadding, revealedViewFrame.size.width - (shareFormPadding*2), revealedViewFrame.size.height - (shareFormPadding *2))];
    textView.delegate = self;
    [splitBody addSubview:textView];
    textView.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        textView.alpha = 1;
    } completion:^(BOOL complete){
        
        
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
