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
@synthesize hero, heroImageView, overviewContainer;
@synthesize damagePointsLabel, missileSpeedLabel, intelligencePointsLabel, attackRangeLabel, attackDurationLabel, heroNameLabel, armorPointsLabel, castDurationLabel, movementSpeedPointsLabel, factionImageView,roleLabel,primaryAttributeImageView, agilityPointsLabel, sightRangeLabel, strengthPointsLabel, turnRateLabel;
@synthesize scrollView, bioLabel, bioTextView;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    CAGradientLayer *makeGradient = [CAGradientLayer layer];
    makeGradient.frame = self.overviewContainer.bounds;
    makeGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:46/255.0 green:48/255.0 blue:48/255.0 alpha:1] CGColor],(id)[[UIColor colorWithRed:35/255.0 green:38/255.0 blue:38/255.0 alpha:1] CGColor], nil];
    [self.overviewContainer.layer insertSublayer:makeGradient atIndex:1];

    self.overviewContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    self.overviewContainer.layer.shadowOffset = CGSizeMake(0,1);
    self.overviewContainer.layer.shadowOpacity = 1;
    self.overviewContainer.layer.shadowRadius = 1.0;
    self.overviewContainer.clipsToBounds = NO;
    
    self.heroNameLabel.text = hero.name;

    self.heroImageView.image = [UIImage imageWithContentsOfFile:hero.detailImgPath];
    self.heroImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.heroImageView.layer.shadowOffset = CGSizeMake(2, 2);
    self.heroImageView.layer.shadowOpacity = 1;
    self.heroImageView.layer.shadowRadius = 5.0;
    self.heroImageView.clipsToBounds = NO;
    
    self.strengthPointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.strPoints, hero.strGain];
    self.intelligencePointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.intelPoints, hero.intelGain];
    self.agilityPointsLabel.text = [NSString stringWithFormat:@"%@ +%@",hero.agilPoints, hero.agilGain];
    self.damagePointsLabel.text = hero.damage;
    self.movementSpeedPointsLabel.text = [NSString stringWithFormat:@"%@",hero.ms];
    self.armorPointsLabel.text = [NSString stringWithFormat:@"%@",hero.armour];
    self.roleLabel.text = hero.role;

    self.sightRangeLabel.text =  hero.sight;
    self.attackRangeLabel.text =  [NSString stringWithFormat:@"%@",hero.attackRange];
    self.missileSpeedLabel.text =   [NSString stringWithFormat:@"%@",hero.missileSpeed];
    
    self.bioLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.bioLabel.numberOfLines = 0;
    self.bioLabel.text = hero.bio;
    [self.bioLabel sizeToFit];
    self.bioLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.bioLabel.layer.borderWidth = 3.0;
    
    [self.scrollView setContentSize:CGSizeMake(0, self.bioLabel.frame.origin.y + self.bioLabel.frame.size.height+100)];

    int backgroundGradientHeight = self.scrollView.contentSize.height;    
    if (backgroundGradientHeight<789) {
        backgroundGradientHeight = 789;
    }
    
    UIView *sbview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, backgroundGradientHeight)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = sbview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:35/ 255.0 green:36/ 255.0 blue:37/ 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:10/ 255.0 green:11/ 255.0 blue:12/ 255.0 alpha:1.0].CGColor, nil];
    [sbview.layer insertSublayer:gradient atIndex:0];
    [self.view insertSubview:sbview atIndex:0];
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
    [self setBioTextView:nil];
    [self setBioLabel:nil];
    [super viewDidUnload];
}



@end
