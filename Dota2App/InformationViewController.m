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
@synthesize damagePointsLabel, missileSpeedLabel, intelligencePointsLabel, attackSpeedLevelOneLabel, attackRangeLabel, attackDurationLabel, heroNameLabel, armorLevelOneLabel, armorPointsLabel, castDurationLabel, movementSpeedPointsLabel, damageLevelOneLabel, factionImageView, bioLabel,roleLabel,primaryAttributeImageView, hitPointsLevelOneLabel, agilityPointsLabel, sightRangeLabel, manaLevelOneLabel, strengthPointsLabel, turnRateLabel;


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
    
    self.damagePointsLabel.text = [NSString stringWithFormat:@"%@ - %@",hero.dmgMin, hero.dmgMax];
    //    self.movementSpeedPointsLabel.text = hero.movementSpeed;
    self.armorPointsLabel.text = [NSString stringWithFormat:@"%@",hero.armour];
    
    self.roleLabel.text = hero.role;
    
    self.bioLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.bioLabel.numberOfLines = 0;
    
    self.turnRateLabel.text = [NSString stringWithFormat:@"%@",hero.turnRate];
    self.sightRangeLabel.text =  [NSString stringWithFormat:@"%@/%@",hero.sightDay,hero.sightNight];
    self.attackRangeLabel.text =  [NSString stringWithFormat:@"%@",hero.attackRange];
    self.missileSpeedLabel.text =   [NSString stringWithFormat:@"%@",hero.missileSpeed];
    self.attackDurationLabel.text =   [NSString stringWithFormat:@"%@",hero.attackBackswing];
    self.castDurationLabel.text =   [NSString stringWithFormat:@"%@",hero.castBackswing];
    
    //for testing only
    
    self.bioLabel.text = hero.bio;
    
    [self.bioLabel sizeToFit];
    
    self.hitPointsLevelOneLabel.text = [NSString stringWithFormat:@"%@",hero.hp];
    self.manaLevelOneLabel.text = [NSString stringWithFormat:@"%@",hero.mana];
    self.damageLevelOneLabel.text = [NSString stringWithFormat:@"%@-%@",hero.dmgMin, hero.dmgMax];
    self.armorLevelOneLabel.text = [NSString stringWithFormat:@"%@",hero.armour];
    self.attackSpeedLevelOneLabel.text = [NSString stringWithFormat:@"%@",hero.attackBackswing];
    
    
    
    //To access abilities use hero.hasAbility (NSSet *), it contains Ability objects.
}
- (void)viewDidUnload {
    
    [self setHeroImageView:nil];
    [self setHeroNameLabel:nil];
    [self setPrimaryAttributeImageView:nil];
    [self setBioLabel:nil];
    [self setFactionImageView:nil];
    
    
    
    [self setStrengthPointsLabel:nil];
    [self setAgilityPointsLabel:nil];
    [self setIntelligencePointsLabel:nil];
    [self setDamagePointsLabel:nil];
    [self setMovementSpeedPointsLabel:nil];
    [self setArmorPointsLabel:nil];
    [self setRoleLabel:nil];
    [self setBioLabel:nil];
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
    [super viewDidUnload];
}



@end
