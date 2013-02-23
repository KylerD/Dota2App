//
//  ShareViewController.h
//  Dota2App
//
//  Created by Luke McNeice on 02/02/2013.
//
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

@property(nonatomic,retain) NSString * context;
@property(nonatomic,retain) IBOutlet UIButton * shareButton;
@property(nonatomic,retain) IBOutlet UITextView * shareMessage;
- (IBAction)share:(id)sender;
- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)getScreenFrameForCurrentOrientation;
- (void)postToTwitter:(NSString*)body;
- (void)shareWithContext:(NSString*)ctx;
@end
