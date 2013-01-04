//
//  ItemsDetailViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 29/12/2012.
//
//

#import "ItemsDetailViewController.h"
#import "DetailViewController.h"

@interface ItemsDetailViewController ()

@end

@implementation ItemsDetailViewController
@synthesize item = _item, manaCost,manaImage,lore,name;





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
{
    int count =1;
            NSLog(@"%@ is made from:",_item.name);
    for (NSString * itemConsumables in _item.components) {
        NSLog(@"%i. %@",count, itemConsumables);
    }
    NSLog(@"%@",_item.lore);
    
    
    
    
    self.name.text = _item.name;
    self.lore.text = _item.lore;
    self.description.text = [_item.desc stringByReplacingOccurrencesOfString:@"<br />"withString:@""];
    self.manaCost.text = [NSString stringWithFormat:@"%@",_item.manaCost];
    self.cost.text = [NSString stringWithFormat:@"%@",_item.cost];
    self.cooldown.text = [NSString stringWithFormat:@"%@", _item.coolDown];
    
    self.lore.lineBreakMode = UILineBreakModeWordWrap;
    self.lore.numberOfLines = 0;
    self.description.lineBreakMode = UILineBreakModeWordWrap;
    self.description.numberOfLines = 0;
   
    self.lore.frame = CGRectMake(self.lore.frame.origin.x,self.lore.frame.origin.y,670,self.lore.frame.size.height);
    
    [self.lore sizeToFit];
    
    self.description.frame = CGRectMake(self.description.frame.origin.x,self.lore.frame.origin.y+self.lore.frame.size.height+30,670,self.description.frame.size.height);

    [self.description sizeToFit];
    

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
/*
 "mekansm":{
 "img":"mekansm_lg.png",
 "dname":"Mekansm",
 "qual":"rare",
 "cost":2306,
 "desc":"Active: Restore - Heals 250 HP and gives +2 armor in an area.<br \/>\nPassive: Mekansm Aura - Bonus HP Regen in an area.<br \/>\n<br \/>\nMultiple instances of Mekansm Aura do not stack.",
 "attrib":"+ <span class=\"attribVal\">5<\/span> <span class=\"attribValText\">All Attributes<\/span><br \/>\n+ <span class=\"attribVal\">5<\/span> <span class=\"attribValText\">Armor<\/span><br \/>\nBONUS HP REGEN: <span class=\"attribVal\">4<\/span>",
 "mc":150,
 "cd":45,
 "lore":"A glowing jewel formed out of assorted parts that somehow fit together perfectly.",
 "components":[
 "headdress",
 "buckler"
 ],
 "created":true
 }
 */
@end
