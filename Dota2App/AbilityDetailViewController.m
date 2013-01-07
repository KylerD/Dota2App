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
    //Set the mana cost
    NSString *manaCost = [NSString stringWithFormat:@"Mana cost: %@", self.ability.mc];
    [self.mcLabel setText:manaCost];
    //Set the cooldown
    NSString *cooldown = [NSString stringWithFormat:@"Cooldown: %@", self.ability.cd];
    [self.cdLabel setText:cooldown];
    

    
    NSDictionary * d = [NSKeyedUnarchiver unarchiveObjectWithData:self.ability.dynamic];
   

   
    [self makeDatHotAssGridWithThisBadassDynamicDictionary:d];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:ability.imagePath]) {
        self.abilityImage.image = [UIImage imageWithContentsOfFile:ability.imagePath];
    } else {
        //In this case image path is just the bundled image name.
        self.abilityImage.image = [UIImage imageNamed:ability.imagePath];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.ability.videoUrl]];
    [self.videoWebView loadRequest:request];
}


-(void)makeDatHotAssGridWithThisBadassDynamicDictionary:(NSDictionary*)badassDictionary{
    int gridSize = [badassDictionary count];
    int y = 164; //193 29

    

    for (int count = 0; count<gridSize; count++) {
        
        
        if (count==2||count==4) {
            y = 193;
        }
        
        UILabel * gridLabel = [[UILabel alloc] init];

        
        
        if (count%2==0) {
            gridLabel.frame = CGRectMake(392,y,100,40);
        }
        else{
            gridLabel.frame = CGRectMake(20,y,100,40);
        }
        [gridLabel setBackgroundColor:[UIColor clearColor]];
        gridLabel.textColor = [UIColor whiteColor];
        [gridLabel sizeToFit];
        [self.view addSubview:gridLabel];
    }
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
