//
//  PagedWelcome
//  pagingComponent
//
//  Created by Luke McNeice on 13/01/2013.
//  Copyright (c) 2013 Luke McNeice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledPageControl.h"
#import "DismissModalParentDelgate.h"

@interface PagedWelcome : UIViewController <UIScrollViewDelegate,DismissModalParentDelgate>
@property (nonatomic,retain) StyledPageControl * pageControl;
@property (nonatomic,retain) UIScrollView * scrollView;
@property (nonatomic,retain) NSArray * views;
@property (nonatomic,retain) NSTimer * pageTimer;
@property BOOL pageControlUsed;
- (void)stopAutoPaging;
- (void)startAutoPaging;
@end
