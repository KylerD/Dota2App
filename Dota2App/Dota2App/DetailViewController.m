  //
//  DetailViewController.m
//  Dota2App
//
//  Created by  Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Hero.h"
#import "HeroCell.h"
#import "InformationViewController.h"
#import "AbilitiesViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
@synthesize iconImageView, hero = _hero;
@synthesize segment;
@synthesize masterPopoverController;

#pragma mark - Managing the detail item

- (void)setHero:(Hero *)hero {
    if (_hero != hero) {
        _hero = hero;
    }
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }

    if (_hero) {
        [self configureView];
    }
}

- (void)configureView {
    UIImage *icon = [UIImage imageNamed:_hero.iconImage];

    
    [iconImageView setImage:icon];

    
    // add viewController so you can switch them later.
    UIViewController *vc = [self viewControllerForSegmentIndex:self.segment.selectedSegmentIndex];
    [self addChildViewController:vc];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    currentVC = vc;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    [super viewDidLoad];
    [self configureView];
    infoVCSelected = YES;


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Segment contorl
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    [self addChildViewController:vc];
    [self transitionFromViewController:currentVC toViewController:vc duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [currentVC.view removeFromSuperview];
        vc.view.frame = self.view.bounds;
        [self.view addSubview:vc.view];
    } completion:^(BOOL finished) {
        [vc didMoveToParentViewController:self];
        [currentVC removeFromParentViewController];
        currentVC = vc;
    }];
    
   
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InformationVC"];
            infoVCSelected = YES;
            break;
        case 1:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AbilityVC"];
            infoVCSelected = NO;
            break;
        case 2:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BuildsVC"];
            infoVCSelected = NO;
            break;
        default:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InformationVC"];
            infoVCSelected = YES;
            break;
    }
    
    return vc;
}
@end