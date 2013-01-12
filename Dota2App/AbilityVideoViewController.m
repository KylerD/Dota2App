//
//  AbilityVideoViewController.m
//  Dota2App
//
//  Created by Stuart McKee on 10/01/2013.
//
//

#import "AbilityVideoViewController.h"

@interface AbilityVideoViewController ()

@end

@implementation AbilityVideoViewController
@synthesize abilityVideo, ability;

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
    [self.abilityVideo  loadHTMLString:@"<html><body style=\"background-color:black;\"></body></html>" baseURL:nil];
    
    [self performSelector:@selector(loadURL:) withObject:nil afterDelay:0.1];
    
    
    
}

-(void)loadURL:(id)sender{
    
    [self.abilityVideo  stopLoading]; //added this line to stop the previous request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.ability.videoUrl]];
    [self.abilityVideo loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *urlRequest = [request URL];
    
    if ([[urlRequest absoluteString] isEqualToString:self.ability.videoUrl]) {
        return YES;
    }
    
    return NO;
}


@end
