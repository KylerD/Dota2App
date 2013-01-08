//
//  InformationViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import "InformationViewController.h"
#import "DetailViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface InformationViewController ()

@end
@implementation InformationViewController
@synthesize hero, heroImageView;
@synthesize damagePointsLabel, missileSpeedLabel, intelligencePointsLabel, attackSpeedLevelOneLabel, attackRangeLabel, attackDurationLabel, heroNameLabel, armorLevelOneLabel, armorPointsLabel, castDurationLabel, movementSpeedPointsLabel, damageLevelOneLabel, factionImageView,roleLabel,primaryAttributeImageView, hitPointsLevelOneLabel, agilityPointsLabel, sightRangeLabel, manaLevelOneLabel, strengthPointsLabel, turnRateLabel;
@synthesize scrollView;

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
    
    
    UIView *sbview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = sbview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:35/ 255.0 green:36/ 255.0 blue:37/ 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:10/ 255.0 green:11/ 255.0 blue:12/ 255.0 alpha:1.0].CGColor, nil];
    [sbview.layer insertSublayer:gradient atIndex:0];
    
    [self.view insertSubview:sbview atIndex:0];
    
    self.heroNameLabel.text = hero.name;
    self.factionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",hero.faction]];
    

    self.heroImageView.image = [UIImage imageWithContentsOfFile:hero.detailImgPath];
    
    self.strengthPointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.strPoints, hero.strGain];
    self.intelligencePointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.intelPoints, hero.intelGain];
    
    self.agilityPointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.agilPoints, hero.agilGain];
    
    self.damagePointsLabel.text = hero.damage;
    self.movementSpeedPointsLabel.text = [NSString stringWithFormat:@"%@",hero.ms];
    self.armorPointsLabel.text = [NSString stringWithFormat:@"%@",hero.armour];
    NSLog(@"%@",hero.role);
    self.roleLabel.text = hero.role;
    
    self.bioLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.bioLabel.numberOfLines = 0;

    self.sightRangeLabel.text =  hero.sight;
    self.attackRangeLabel.text =  [NSString stringWithFormat:@"%@",hero.attackRange];
    self.missileSpeedLabel.text =   [NSString stringWithFormat:@"%@",hero.missileSpeed];
    
    self.bioLabel.text = hero.bio;
    
    [self.bioLabel sizeToFit];

    [self.scrollView setContentSize:CGSizeMake(0, self.bioLabel.frame.origin.y + self.bioLabel.frame.size.height+100)];

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
    [self setBioLabel:nil];
    [super viewDidUnload];
}



@end
