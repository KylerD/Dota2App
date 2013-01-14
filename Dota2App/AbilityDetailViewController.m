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
@synthesize titleLabel, descriptionLabel, mcLabel, cdLabel, abilityImage, videoWebView;
@synthesize mcIcon, cdIcon, scrollView, videoButton;

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
    
    self.abilityImage.image = [UIImage imageWithContentsOfFile:ability.imagePath];
    
    [self configureView];
  
    [self.videoWebView  loadHTMLString:@"<html><body style=\"background-color:black;\"></body></html>" baseURL:nil];

    [self performSelector:@selector(loadURL:) withObject:nil afterDelay:0.1];
    
    
    
}

-(void)loadURL:(id)sender{

    [self.videoWebView  stopLoading]; //added this line to stop the previous request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.ability.videoUrl]];
    [self.videoWebView loadRequest:request];

}

- (void)configureView {

        //Set the title
        [self.titleLabel setText:self.ability.name];
        //Set the mana cost
        
 
        self.descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.descriptionLabel.numberOfLines = 0;
    
        [self.descriptionLabel setText:self.ability.notes];
        [self.descriptionLabel sizeToFit];
        
//        [self makeDatHotAssIPHONEGridWithThisBadassDynamicDictionary:theDictionaryOfTheGods];
        
        
        /*   This will be set to be below the bottom of the hot ass grid
        [self.loreLabel setText:self.ability.lore];
        [self.loreLabel sizeToFit];
        self.loreLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x,self.descriptionLabel.frame.size.height+self.descriptionLabel.frame.origin.y,self.loreLabel.frame.size.width, self.loreLabel.frame.size.height);
         
         */
        if ([ability.isPassive boolValue]) {
            [self.mcLabel setHidden:TRUE];
            [self.cdLabel setHidden:TRUE];
            [self.mcIcon setHidden:TRUE];
            [self.cdIcon setHidden:TRUE];
        }
        else{
            [self.mcLabel setText:self.ability.mc];
            [self.cdLabel setText:self.ability.cd];
        }
        
    
    
    NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData: [self.ability.dynamic dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: nil];

        
        
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
        [self makeiPhoneGridWithDictionary:JSON];
    }
    else{
    
        [self makeiPadGridWithDictionary:JSON];
    }
    
}


-(void)makeiPadGridWithDictionary: (NSDictionary*)badassDictionary{
    int gridSize = [badassDictionary count];
    int y = self.descriptionLabel.frame.origin.y+self.descriptionLabel.frame.size.height; //193 29

    NSArray * keys =[badassDictionary allKeys];

    for (int count = 0; count<gridSize; count++) {
        
    
        
        if (count%2 ==0){
            y+=29;
        }

        
        UILabel * gridLabel = [[UILabel alloc] init];

        NSLog(@"%@",[badassDictionary valueForKey:@"Radius"]);
        
        if (count%2==0) {
            gridLabel.frame = CGRectMake(392,y,300,200);
        }
        else{
            gridLabel.frame = CGRectMake(20,y,300,200);
        }
        [gridLabel setBackgroundColor:[UIColor clearColor]];
        gridLabel.textColor = [UIColor whiteColor];
        
        gridLabel.lineBreakMode = UILineBreakModeWordWrap;
        gridLabel.numberOfLines = 0;
        
        
        
        gridLabel.text = [NSString stringWithFormat:@"%@: %@",[keys objectAtIndex:count],[badassDictionary valueForKey:[keys objectAtIndex:count]]];
        
        
                [gridLabel sizeToFit];
        [self.scrollView addSubview:gridLabel];
        
        
        [self.videoWebView setFrame:CGRectMake(self.videoWebView.frame.origin.x, gridLabel.frame.origin.y+gridLabel.frame.size.height+20, self.videoWebView.frame.size.width, self.videoWebView.frame.size.height)];
        
       
        
    }
    UILabel * loreLabel = [[UILabel alloc] init];
    
    [loreLabel setBackgroundColor:[UIColor clearColor]];
    loreLabel.textColor = [UIColor whiteColor];
    
    loreLabel.lineBreakMode = UILineBreakModeWordWrap;
    loreLabel.numberOfLines = 0;
    loreLabel.text = self.ability.lore;
    [loreLabel setFrame:CGRectMake(self.videoWebView.frame.origin.x, self.videoWebView.frame.origin.y+self.videoWebView.frame.size.height/1.5, 670, loreLabel.frame.size.height)];
    [loreLabel sizeToFit];
    
    [self.scrollView addSubview:loreLabel];
    
    [self.scrollView setContentSize:CGSizeMake(0, loreLabel.frame.origin.y + loreLabel.frame.size.height+100)];
}

- (void)makeiPhoneGridWithDictionary: (NSDictionary*)badassDictionary {
    int gridSize = [badassDictionary count];
    int y = self.descriptionLabel.frame.origin.y+self.descriptionLabel.frame.size.height; //193 29
    
    NSArray * keys =[badassDictionary allKeys];
    
    for (int count = 0; count<gridSize; count++) {
        
        
        
        if (count%2 ==0){
            y+=29;
        }
        
        
        UILabel * gridLabel = [[UILabel alloc] init];
        
        NSLog(@"%@",[badassDictionary valueForKey:@"Radius"]);
        
        
        gridLabel.frame = CGRectMake(20,y,300,200);
        
        [gridLabel setBackgroundColor:[UIColor clearColor]];
        gridLabel.textColor = [UIColor whiteColor];
        
        gridLabel.lineBreakMode = UILineBreakModeWordWrap;
        gridLabel.numberOfLines = 0;
        
        
        
        gridLabel.text = [NSString stringWithFormat:@"%@: %@",[keys objectAtIndex:count],[badassDictionary valueForKey:[keys objectAtIndex:count]]];
        
        
        [gridLabel sizeToFit];
        [self.scrollView addSubview:gridLabel];
        
        [self.videoButton setFrame:CGRectMake(self.videoButton.frame.origin.x, gridLabel.frame.origin.y+gridLabel.frame.size.height+20, self.videoButton.frame.size.width, self.videoButton.frame.size.height)];

    }
    UILabel * loreLabel = [[UILabel alloc] init];
    
    [loreLabel setBackgroundColor:[UIColor clearColor]];
    loreLabel.textColor = [UIColor whiteColor];
    
    loreLabel.lineBreakMode = UILineBreakModeWordWrap;
    loreLabel.numberOfLines = 0;
    loreLabel.text = self.ability.lore;
    [loreLabel setFrame:CGRectMake(20, self.videoWebView.frame.origin.y+self.videoWebView.frame.size.height+20, 280, loreLabel.frame.size.height)];
    [loreLabel sizeToFit];
    
    [self.scrollView addSubview:loreLabel];
    
    [self.scrollView setContentSize:CGSizeMake(0, loreLabel.frame.origin.y + loreLabel.frame.size.height+100)];

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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AbilityVideo"]) {
        

        AbilityVideoViewController *abilityDetailVC = (AbilityVideoViewController *)[segue destinationViewController];
        [abilityDetailVC setAbility:self.ability];
        
    }
}

@end
