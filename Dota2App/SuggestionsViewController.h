//
//  SuggestionsViewController
//  Dota2App
//
//  Created by Luke McNeice on 13/01/2013.
//
//

#import <UIKit/UIKit.h>
#import "PagingDelegate.h"


@interface SuggestionsViewController : UIViewController{
    IBOutlet UILabel * suggestLabelButton;
}
@property (nonatomic,retain) IBOutlet UIImageView * backgroundImage;
@property (nonatomic,retain) IBOutlet UIView * messagePanel;
@property  (nonatomic,assign) id <PagingDelegate> delegate;
- (IBAction)close:(id)sender;
- (IBAction)suggest:(id)sender;
- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;
@end
