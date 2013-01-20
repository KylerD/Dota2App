//
//  AbilityDetailViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import "AbilityDetailViewController.h"
#import "QuartzCore/CALayer.h"
#import <QuartzCore/QuartzCore.h>
#import "OrderedDictionary.h"

@interface AbilityDetailViewController (){
    OrderedDictionary * dynamicAbilityAttrributes;
}

@end

@implementation AbilityDetailViewController
@synthesize ability;
@synthesize titleLabel, descriptionLabel, mcLabel, cdLabel, abilityImage, videoWebView, overviewContainer;
@synthesize mcIcon, cdIcon, scrollView, videoButton,tableView;

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
    
    self.abilityImage.image = [UIImage imageWithContentsOfFile:ability.imagePath];
    
    self.abilityImage.layer.shadowColor = [UIColor blackColor].CGColor;
    self.abilityImage.layer.shadowOffset = CGSizeMake(2, 2);
    self.abilityImage.layer.shadowOpacity = 1;
    self.abilityImage.layer.shadowRadius = 5.0;
    self.abilityImage.clipsToBounds = NO;
    
    CAGradientLayer *makeGradient = [CAGradientLayer layer];
    makeGradient.frame = self.overviewContainer.bounds;
    makeGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:46/255.0 green:48/255.0 blue:48/255.0 alpha:1] CGColor],(id)[[UIColor colorWithRed:35/255.0 green:38/255.0 blue:38/255.0 alpha:1] CGColor], nil];
    [self.overviewContainer.layer insertSublayer:makeGradient atIndex:1];
    
    self.overviewContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    self.overviewContainer.layer.shadowOffset = CGSizeMake(0,1);
    self.overviewContainer.layer.shadowOpacity = 1;
    self.overviewContainer.layer.shadowRadius = 1.0;
    self.overviewContainer.clipsToBounds = NO;
    
    [self configureView];
    //videoWebView.hidden = YES;
    //Stops the white flash prior to loading vids
    [self.videoWebView  loadHTMLString:@"<html><body style=\"background-color:black;\"></body></html>" baseURL:nil];
    [self performSelector:@selector(loadURL:) withObject:nil afterDelay:0.1];
}

-(void)loadURL:(id)sender{
    
    [self.videoWebView  stopLoading]; //stops the previous request (static black bg)
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.ability.videoUrl]];
    [self.videoWebView loadRequest:request];
    
}

- (void)configureView {
    
    //Set the title
    [self.titleLabel setText:self.ability.name];
    //Set the mana cost
    
    self.descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.descriptionLabel.numberOfLines = 0;
    
    NSMutableString * loreString = [NSMutableString stringWithFormat:@"%@",self.ability.lore];
    
    if (![loreString isEqualToString:@""]) {
        [loreString appendFormat:@"\n\n"];
    }
    
    NSString * descriptionString = [NSString stringWithFormat:@"%@%@",loreString,self.ability.notes];
    
    [self.descriptionLabel setText:descriptionString];
    [self.descriptionLabel sizeToFit];
    
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
    
     NSDictionary * JSONDict = [NSJSONSerialization JSONObjectWithData: [self.ability.dynamic dataUsingEncoding:NSUTF8StringEncoding]
                                                                options: NSJSONReadingMutableContainers
                                                                  error: nil];
    
    dynamicAbilityAttrributes = [OrderedDictionary dictionaryWithDictionary:JSONDict];
    
    int keyCount = [[dynamicAbilityAttrributes allKeys] count];
    int tableheightCalculation = (keyCount * 44) + 40;
    CGRect f =   tableView.frame;
    tableView.backgroundView = nil;
    f.size.height = tableheightCalculation;
    f.origin.y = descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height + 10;
    tableView.frame = f;    
    
    f = videoWebView.frame;
    f.origin.y = tableView.frame.origin.y+tableView.frame.size.height + 20;
    videoWebView.frame = f;
    
    f = scrollView.frame;
    f = CGRectMake(0, 0, self.view.frame.size.width-50,self.view.frame.size.height);
    scrollView.frame =f;
    CGSize s = scrollView.contentSize;
    
    
    int randomSub = 0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        randomSub = 300;
    }
    
    
    s.height = videoWebView.frame.origin.y+videoWebView.frame.size.height-randomSub;
    scrollView.contentSize = s;
    
    //    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
    //        [self makeiPhoneGridWithDictionary:JSON];
    //    }
    //    else{
    //        [self makeiPadGridWithDictionary:JSON];
    //    }
}


- (NSString*)attribValueToString:(id)value{
    
    NSString * result;
    
    if([value isKindOfClass:[NSString class]]){
        result = [value copy];
    } else if([value isKindOfClass:[NSArray class]]){
        NSMutableString * sb = [NSMutableString string];
        
        for (id val in (NSArray*)value) {
            [sb appendFormat:@"%@, ",val];
        }
        
        if (![sb isEqualToString:@""]){
            NSRange lastComma = {sb.length-2,2};
            [sb deleteCharactersInRange:lastComma];
        }
        
        result = [sb copy];
        
    }
    
    return result;
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dynamicAbilityAttrributes allKeys] count];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DynamicAttribCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


-(NSString *)controller:(NSFetchedResultsController *)controller
sectionIndexTitleForSectionName:(NSString *)sectionName {
    return sectionName;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{ 
    
    NSString * key = [dynamicAbilityAttrributes keyAtIndex:indexPath.row];
    NSString * value = [self attribValueToString:[dynamicAbilityAttrributes valueForKey:key]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[key lowercaseString] capitalizedString]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",value];
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
