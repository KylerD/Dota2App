//
//  ItemsDetailViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import "ItemsDetailViewController.h"

@interface ItemsDetailViewController ()

@end

@implementation ItemsDetailViewController
@synthesize item;

#pragma mark - View LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
