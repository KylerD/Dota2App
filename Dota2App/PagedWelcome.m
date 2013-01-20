//
//  ViewController.m
//  pagingComponent
//
//  Created by Luke McNeice on 13/01/2013.
//  Copyright (c) 2013 Luke McNeice. All rights reserved.
//

#import "PagedWelcome.h"
#import "HelloViewController.h"
#import "UpdatesViewController.h"
#import "SuggestionsViewController.h"
#import "AppDelegate.h"

@interface PagedWelcome ()
- (IBAction)changePage:(id)sender;
@end

@implementation PagedWelcome
@synthesize pageControl,scrollView,views,pageControlUsed,pageTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)dismissModalFromParent{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)stopAutoPaging{
    [pageTimer invalidate];
    pageTimer = nil;
}

- (void)startAutoPaging{
    pageTimer = [NSTimer scheduledTimerWithTimeInterval: 3
                                                 target: self
                                               selector: @selector(movePage:)
                                               userInfo: nil
                                                repeats: YES];
}

- (void)movePage:(id)sender{
    int current = pageControl.currentPage;
    int max = pageControl.numberOfPages;
    if(current<(max-1)){
        pageControl.currentPage +=1;
    } else pageControl.currentPage = 0;
    
    [self changePage:sender];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self resizeViewsForOrientation:toInterfaceOrientation addingViews:NO];
}

-(void)printRect:(CGRect)f{
    NSLog(@"%f,%f,%f,%f",f.origin.x,f.origin.y,f.size.width,f.size.height);
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

- (void)resizeViewsForOrientation:(UIInterfaceOrientation)orientation addingViews:(BOOL)addViews{
    CGRect current = [self getScreenFrameForOrientation:orientation];
    
    //[self printRect:current];
    
    scrollView.frame = current;
    
    for (int i = 0; i < [views count]; i++) {
        UIViewController * vc = [views objectAtIndex:i];
        
        CGRect f = CGRectMake(current.size.width*i, 0, current.size.width,current.size.height);
        //[self printRect:f];
        vc.view.frame = f;
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
        
        if (addViews && !vc.view.superview) {
            [scrollView addSubview:vc.view];
        }
        
    }
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width*[views count], scrollView.frame.size.height)];
    
    pageControl.frame =  CGRectMake(0,current.size.height-20, current.size.width, 20);
    [pageControl setNeedsDisplay];
    [self changePage:nil];
}

- (void)configureView{
    self.view.backgroundColor = [UIColor blackColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setAutoresizesSubviews:YES ];
    
    HelloViewController * v1 = [[HelloViewController alloc] initWithNibName:@"HelloViewController" bundle:nil];
    v1.delegate = self;
    
    SuggestionsViewController * v3 = [[SuggestionsViewController alloc] initWithNibName:@"SuggestionsViewController" bundle:nil];
       v3.delegate = self;
    
    UpdatesViewController * v2 = [[UpdatesViewController alloc] initWithNibName:@"UpdatesViewController" bundle:nil];
       v2.delegate = self;
    
    views = [NSArray arrayWithObjects:v1, v2, v3, nil];
    
    pageControl = [[StyledPageControl alloc] init];
    pageControl.numberOfPages = [views count];
    pageControl.currentPage = 0;
    [pageControl setCoreNormalColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    [pageControl setCoreSelectedColor:[UIColor whiteColor]];
    [pageControl setGapWidth:15];
    [pageControl setDiameter:12];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
    
    [self resizeViewsForOrientation:[UIApplication sharedApplication].statusBarOrientation  addingViews:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView {
    pageControlUsed = NO;
    CGFloat pageWidth = theScrollView.frame.size.width;
    int page = floor((theScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    [self stopAutoPaging];
    
}

- (IBAction)changePage:(id)sender {
    pageControlUsed=YES;
    int page = pageControl.currentPage;
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
    if ([sender isKindOfClass:[StyledPageControl class]]) {
        [self stopAutoPaging];
        pageControlUsed = YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
