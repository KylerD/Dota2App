//
//  HelloViewController.h
//  Dota2App
//
//  Created by Luke McNeice on 13/01/2013.
//
//

#import <UIKit/UIKit.h>
#import "PagingDelegate.h"

@interface HelloViewController : UIViewController
@property (nonatomic,retain) IBOutlet UIImageView * backgroundImage;
@property (nonatomic,retain) IBOutlet UIView * welcomePanel;
@property (nonatomic,retain) IBOutlet UIView * sharePanel;
@property  (nonatomic,assign) id <PagingDelegate> delegate;
- (IBAction)close:(id)sender;
- (IBAction)share:(id)sender;
- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;
@end
