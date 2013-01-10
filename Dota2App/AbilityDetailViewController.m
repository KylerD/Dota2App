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

-(void)configureView{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
        //Set the title
        [self.titleLabel setText:self.ability.name];
        //Set the mana cost
        
 
        self.descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.descriptionLabel.numberOfLines = 0;
        self.loreLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.loreLabel.numberOfLines = 0;
        [self.descriptionLabel setText:self.ability.notes];
        [self.descriptionLabel sizeToFit];
        
//        [self makeDatHotAssIPHONEGridWithThisBadassDynamicDictionary:theDictionaryOfTheGods];
        
        
        /*   This will be set to be below the bottom of the hot ass grid
        [self.loreLabel setText:self.ability.lore];
        [self.loreLabel sizeToFit];
        self.loreLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x,self.descriptionLabel.frame.size.height+self.descriptionLabel.frame.origin.y,self.loreLabel.frame.size.width, self.loreLabel.frame.size.height);
         
         */
        if ([ability.isPassive boolValue]) {
            
        }
        else{
            [self.mcLabel setText:self.ability.mc];
            [self.cdLabel setText:self.ability.cd];
        }
        
    }
    
    
    NSDictionary * d = [NSKeyedUnarchiver unarchiveObjectWithData:self.ability.dynamic];
        
        


    
}


-(void)makeDatHotAssIPADGridWithThisBadassDynamicDictionary:(NSDictionary*)badassDictionary{
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

-(void)makeDatHotAssIPHONERowsWithThisBadassDynamicDictionary:(NSDictionary*)badassDictionary{
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
