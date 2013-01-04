//
//  AbilityDetailViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import "AbilityDetailViewController.h"

@interface AbilityDetailViewController ()

@end

@implementation AbilityDetailViewController
@synthesize ability;
@synthesize titleLabel, descriptionLabel, mcLabel, cdLabel, abilityImage, affectsLabel, damageTypeLabel, radiusLabel, videoWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{   NSLog(@"%@", self.ability);
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Set the title
    [self.titleLabel setText:self.ability.name];
    //Set the description
    [self.descriptionLabel setText:self.ability.notes];
    //Set the mana cost
    NSString *manaCost = [NSString stringWithFormat:@"Mana cost: %@", self.ability.mc];
    [self.mcLabel setText:manaCost];
    //Set the cooldown
    NSString *cooldown = [NSString stringWithFormat:@"Cooldown: %@", self.ability.cd];
    [self.cdLabel setText:cooldown];
    
    self.radiusLabel.text = [NSString stringWithFormat:@"Radius: %@", self.ability.radius];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:ability.imagePath]) {
        self.abilityImage.image = [UIImage imageWithContentsOfFile:ability.imagePath];
    }
    
        
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.ability.videoUrl]];
    [self.videoWebView loadRequest:request];


}




#pragma mark -
#pragma mark UIWebViewDelegate
//To check if youtube try to show the overview page of m.youtube.com or the current movie
//if the user click on the youtube logo this method stop loading the mobile page
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *urlRequest = [request URL];
    
    if ([[urlRequest absoluteString] isEqualToString:self.ability.videoUrl]) {
        return YES;
    }
    
    return NO;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
