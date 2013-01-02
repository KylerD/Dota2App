//
//  AbilityVideoViewController.m
//  Dota2App
//
//  Created by Luke McNeice on 29/12/2012.
//
//

#import "AbilityVideoViewController.h"


@interface AbilityVideoViewController ()

@end


@implementation AbilityVideoViewController

@synthesize youTubeView,url;

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
    
self.youTubeView = [[YouTubeView alloc] initWithStringAsURL:self.url frame:CGRectMake(100, 170, 120, 120)];
[[self view] addSubview:youTubeView];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
