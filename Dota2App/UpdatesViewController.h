//
//  UpdatesViewController
//  Dota2App
//
//  Created by Luke ; on 13/01/2013.
//
//

#import <UIKit/UIKit.h>
#import "DismissModalParentDelgate.h"


@interface UpdatesViewController : UIViewController
@property (nonatomic,retain) IBOutlet UIImageView * backgroundImage;
@property (nonatomic,retain) IBOutlet UIView * messagePanel;
@property  (nonatomic,assign) id <DismissModalParentDelgate> delegate;
- (IBAction)close:(id)sender;
- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;
@end
