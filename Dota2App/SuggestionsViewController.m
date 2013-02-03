//
//  SuggestionsViewController
//  Dota2App
//
//  Created by Luke McNeice on 13/01/2013.
//
//

#import "SuggestionsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SuggestionsViewController ()

@end

@implementation SuggestionsViewController

@synthesize backgroundImage,messagePanel,delegate;

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
    
    self.messagePanel.layer.cornerRadius = 8;
    self.messagePanel.layer.masksToBounds = YES;
    
    
    suggestLabelButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suggest:)];
    [suggestLabelButton addGestureRecognizer:tapGesture];
    
}

- (IBAction)suggest:(id)sender{
    NSString *mailurl=[NSString stringWithFormat:
                       @"mailto:%@?subject=%@%@&body=%@%@",@"l.mcneice@kainos.com",@"DOTA2 Clarity - Suggestion", @"DOTA2 Clarity"
                       ,@"Hey,\nI have a sugestion.\n\n",@"Sent from the DOTA2Clarity App"];
    
    NSURL * url = [NSURL URLWithString:[mailurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[UIApplication sharedApplication] openURL:url];

}

- (IBAction)close:(id)sender{
    [self.delegate dismissModalFromParent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
