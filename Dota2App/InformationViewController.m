//
//  InformationViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import "InformationViewController.h"
#import "DetailViewController.h"
@interface InformationViewController ()

@end
@implementation InformationViewController
@synthesize hero, heroImageView;
@synthesize damagePointsLabel, missileSpeedLabel, intelligencePointsLabel, attackSpeedLevelOneLabel, attackRangeLabel, attackDurationLabel, heroNameLabel, armorLevelOneLabel, armorPointsLabel, castDurationLabel, movementSpeedPointsLabel, damageLevelOneLabel, factionImageView,roleLabel,primaryAttributeImageView, hitPointsLevelOneLabel, agilityPointsLabel, sightRangeLabel, manaLevelOneLabel, strengthPointsLabel, turnRateLabel;


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
    
    hero = ((DetailViewController *)self.parentViewController).hero;
    
    if (hero) {
        [self configureView];
    }
    
    heroStatsRowItemArray = [[NSArray alloc]initWithObjects:hero.strPoints,hero.agilPoints,hero.intelPoints, nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    NSLog(@"%@",hero.detailImage);
    
    self.heroNameLabel.text = hero.name;
    self.factionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",hero.faction]];
    self.heroImageView.image = [UIImage imageNamed:hero.detailImage];
    
    
    self.strengthPointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.strPoints, hero.strGain];
    self.intelligencePointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.intelPoints, hero.intelGain];
    
    self.agilityPointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.agilPoints, hero.agilGain];
    
    self.damagePointsLabel.text = hero.damage;
    self.movementSpeedPointsLabel.text = [NSString stringWithFormat:@"%@",hero.ms];
    self.armorPointsLabel.text = [NSString stringWithFormat:@"%@",hero.armour];
    
    self.roleLabel.text = hero.role;
    

    
    self.turnRateLabel.text = [NSString stringWithFormat:@"%@",hero.turnRate];
    self.sightRangeLabel.text =  hero.sight;
    self.attackRangeLabel.text =  [NSString stringWithFormat:@"%@",hero.attackRange];
    self.missileSpeedLabel.text =   [NSString stringWithFormat:@"%@",hero.missileSpeed];

    //for testing only
    

    

    self.bioTextView.text = hero.bio;
    
#define MAX_HEIGHT 300
    
    NSString *foo = hero.bio;
    CGSize size = [foo sizeWithFont:[UIFont systemFontOfSize:16]
                  constrainedToSize:CGSizeMake(self.bioTextView.frame.size.width, MAX_HEIGHT)
                      lineBreakMode:UILineBreakModeWordWrap];
    
    
    [self.bioTextView setFont:[UIFont systemFontOfSize:16]];
    [self.bioTextView setFrame:CGRectMake(self.bioTextView.frame.origin.x, self.bioTextView.frame.origin.y, self.bioTextView.frame.size.width, size.height + 10)];
    
    [self.bioTextView setBackgroundColor:[UIColor colorWithRed:35 green:36 blue:37 alpha:0]];

    
    
    
    //To access abilities use hero.hasAbility (NSSet *), it contains Ability objects.
}
- (void)viewDidUnload {
    
    [self setHeroImageView:nil];
    [self setHeroNameLabel:nil];
    [self setPrimaryAttributeImageView:nil];

    [self setFactionImageView:nil];
    
    
    
    [self setStrengthPointsLabel:nil];
    [self setAgilityPointsLabel:nil];
    [self setIntelligencePointsLabel:nil];
    [self setDamagePointsLabel:nil];
    [self setMovementSpeedPointsLabel:nil];
    [self setArmorPointsLabel:nil];
    [self setRoleLabel:nil];

    [self setTurnRateLabel:nil];
    [self setSightRangeLabel:nil];
    [self setAttackRangeLabel:nil];
    [self setMissileSpeedLabel:nil];
    [self setAttackDurationLabel:nil];
    [self setCastDurationLabel:nil];
    [self setHitPointsLevelOneLabel:nil];
    [self setManaLevelOneLabel:nil];
    [self setDamageLevelOneLabel:nil];
    [self setArmorLevelOneLabel:nil];
    [self setAttackSpeedLevelOneLabel:nil];
    [self setBioTextView:nil];
    [super viewDidUnload];
}



@end
