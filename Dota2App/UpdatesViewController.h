//
//  UpdatesViewController
//  Dota2App
//
//  Created by Luke ; on 13/01/2013.
//
//

#import <UIKit/UIKit.h>
#import "PagingDelegate.h"


@interface UpdatesViewController : UIViewController <UITextViewDelegate>
@property (nonatomic,retain) IBOutlet UIImageView * backgroundImage;
@property (nonatomic,retain) IBOutlet UIView * messagePanel;
@property (nonatomic,retain) IBOutlet UIView * contentView;
@property (nonatomic,retain) IBOutlet UIScrollView * scrollView;
@property BOOL isSplit;
@property  (nonatomic,assign) id <PagingDelegate> delegate;

- (IBAction)close:(id)sender;
- (IBAction)facebook:(id)sender;
- (IBAction)twitter:(id)sender;
- (IBAction)google:(id)sender;
- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;
@end
