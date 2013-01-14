//
//  ItemsDetailViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import "ItemsDetailViewController.h"
#import "DetailViewController.h"
#import "ItemCell.h"

@interface ItemsDetailViewController ()

@end

@implementation ItemsDetailViewController
@synthesize item = _item, manaCost,manaImage,lore,name;
@synthesize cost, description, cooldown, cooldownImage, image, tableView;

- (void)setItem:(Item *)item {
    if (_item != item) {
        _item = item;
    }

    if (_item) {
        [self configureView];
    }
}
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
    if (_item) {
        [self configureView];
    }

	// Do any additional setup after loading the view.
    
    
}

-(void)configureView
{   //initially hide the table view
    self.tableView.hidden = YES;
    
    if (![_item.components count]) {
        [_item mapItemComponents];
    }
    
    itemComponents = [_item.components allObjects];
    if (![itemComponents count] == 0) {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
    
    self.name.text = _item.name;
    self.title = _item.name;
    
    self.image.image = [UIImage imageWithContentsOfFile:_item.imgPath];
    
    self.image.layer.shadowColor = [UIColor blackColor].CGColor;
    self.image.layer.shadowOffset = CGSizeMake(2, 2);
    self.image.layer.shadowOpacity = 1;
    self.image.layer.shadowRadius = 5.0;
    self.image.clipsToBounds = NO;

    self.lore.text = _item.lore;
    self.description.text = [_item.desc stringByReplacingOccurrencesOfString:@"<br />"withString:@""];
    self.manaCost.text = [NSString stringWithFormat:@"%@",_item.manaCost];
    self.cost.text = [NSString stringWithFormat:@"%@",_item.cost];
    self.cooldown.text = [NSString stringWithFormat:@"%@", _item.coolDown];
    
    self.lore.lineBreakMode = UILineBreakModeWordWrap;
    self.lore.numberOfLines = 0;
    self.description.lineBreakMode = UILineBreakModeWordWrap;
    self.description.numberOfLines = 0;
    
    CAGradientLayer *makeGradient = [CAGradientLayer layer];
    makeGradient.frame = self.gradient.bounds;
    makeGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:46/255.0 green:48/255.0 blue:48/255.0 alpha:1] CGColor],(id)[[UIColor colorWithRed:35/255.0 green:38/255.0 blue:38/255.0 alpha:1] CGColor], nil];
    [self.gradient.layer insertSublayer:makeGradient atIndex:1];
    
    self.gradient.layer.shadowColor = [UIColor blackColor].CGColor;
    self.gradient.layer.shadowOffset = CGSizeMake(0,1);
    self.gradient.layer.shadowOpacity = 1;
    self.gradient.layer.shadowRadius = 1.0;
    self.gradient.clipsToBounds = NO;
   
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
        self.description.frame = CGRectMake(self.description.frame.origin.x,self.description.frame.origin.y,280,self.description.frame.size.height);
        [self.description sizeToFit];
        self.lore.frame = CGRectMake(self.lore.frame.origin.x,self.description.frame.origin.y+self.description.frame.size.height+30,280,self.lore.frame.size.height);
    }
    else{
        self.description.frame = CGRectMake(self.description.frame.origin.x,self.description.frame.origin.y,670,self.description.frame.size.height);
        [self.description sizeToFit];
        self.lore.frame = CGRectMake(self.lore.frame.origin.x,self.description.frame.origin.y+self.description.frame.size.height+30,670,self.lore.frame.size.height);
    }
    
    [self.lore sizeToFit];
    
    

    
    
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.lore.frame.origin.y + self.lore.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height);

    if ([self.cooldown.text isEqualToString:@"0"]) {
        self.cooldown.hidden = true;
        self.manaCost.hidden = true;
        self.cooldownImage.hidden = true;
        self.manaImage.hidden = true;
    }
    else{
        self.cooldown.hidden = false;
        self.manaCost.hidden = false;
        self.cooldownImage.hidden = false;
        self.manaImage.hidden = false;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Del


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemComponents count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{   //Fetch the hero
    ItemCell *itemCell = (ItemCell *)cell;
    Item *itemComponent = [itemComponents objectAtIndex:[indexPath row]];
    itemCell.cellTitleLabel.text= itemComponent.name;
    //cell.cellImage.image = [UIImage imageNamed:item.imgName];
    itemCell.cellImage.image = [UIImage imageWithContentsOfFile:itemComponent.imgPath];
    
}




@end
