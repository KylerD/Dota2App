//
//  ExtendedDetailViewController.m
//  Dota2App
//
//  Created by Stuart on 12/11/2012.
//
//

#import "ExtendedDetailViewController.h"

@interface ExtendedDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end
@implementation ExtendedDetailViewController

@synthesize detailItem = _detailItem;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize heroPortrait;



- (void)setDetailItem:(Hero *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
    
    if (_managedObjectContext) {
        [self configureView];
    }
}

- (void)configureView
{
    NSLog(@"%@", _detailItem);
    self.title = _detailItem.name;
    self.heroPortrait.image = [UIImage imageNamed:_detailItem.imagePath];
    
}
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
    [self configureView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHeroPortrait:nil];
    [super viewDidUnload];
}
@end
