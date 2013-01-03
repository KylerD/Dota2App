//
//  AbilityDetailViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import "AbilityDetailViewController.h"
#import "AbilityVideoViewController.h"

@interface AbilityDetailViewController ()

@end

@implementation AbilityDetailViewController
@synthesize ability;
@synthesize titleLabel, descriptionLabel, mcLabel, cdLabel, abilityImage, abilityLabel, affectsLabel, damageTypeLabel, healOrDamageLabel, radiusLabel, videoWebView;

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
    NSString *manaCost = [NSString stringWithFormat:@"MANA COST: %@", self.ability.mc];
    [self.mcLabel setText:manaCost];
    //Set the cooldown
    NSString *cooldown = [NSString stringWithFormat:@"COOLDOWN: %@", self.ability.cd];
    [self.cdLabel setText:cooldown];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:ability.imagePath]) {
        self.abilityImage.image = [UIImage imageWithContentsOfFile:ability.imagePath];
    }
    
    // HTML to embed YouTube video
    
    
    NSString* embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
        background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <iframe width=\"%0.0f\" height=\"%0.0f\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
    </body></html>";
    NSString* html = [NSString stringWithFormat:embedHTML, self.videoWebView.frame.size.width, self.videoWebView.frame.size.height, self.ability.videoUrl];
    [self.videoWebView loadHTMLString:html baseURL:nil];    // Load the html into the webview


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"VideoDetail"]) {
        AbilityVideoViewController *detailVC = (AbilityVideoViewController*)[segue destinationViewController];
        [detailVC setUrl:self.ability.videoUrl];
    }
}



@end
