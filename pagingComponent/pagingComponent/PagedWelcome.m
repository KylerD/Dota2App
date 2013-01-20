//
//  ViewController.m
//  pagingComponent
//
//  Created by Luke McNeice on 13/01/2013.
//  Copyright (c) 2013 Luke McNeice. All rights reserved.
//

#import "PagedWelcome.h"

@interface PagedWelcome ()

@end

@implementation PagedWelcome
@synthesize pageControl,scrollView,views,pageControlUsed;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)configureView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor purpleColor];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height)];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    
    UIViewController * v1 = [UIViewController new];
    v1.view.backgroundColor = [UIColor redColor];
    
    UIViewController * v2 = [UIViewController new];
    v2.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController * v3 = [UIViewController new];
    v3.view.backgroundColor = [UIColor greenColor];
    
    views = [NSArray arrayWithObjects:v1, v2, v3, nil];
    
    //Index the Views
    for (int i = 0; i < [views count]; i++) {
        UIViewController * vc = [views objectAtIndex:i];
        vc.view.frame = CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [scrollView addSubview:vc.view];
    }
    
    pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-20, self.view.bounds.size.width, 20)];
    pageControl.numberOfPages = [views count];
    pageControl.currentPage = 0;
    [pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [pageControl setCoreNormalColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    [pageControl setCoreSelectedColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1]];
    [pageControl setGapWidth:15];
    [pageControl setDiameter:12];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
