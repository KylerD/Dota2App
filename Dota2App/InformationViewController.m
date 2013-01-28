//
//  InformationViewController.m
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import "InformationViewController.h"
#import "DetailViewController.h"
#import "PagedWelcome.h"
#import <QuartzCore/QuartzCore.h>


@interface InformationViewController ()

@end
@implementation InformationViewController
#define PADDING 8
@synthesize hero, heroImageView, overviewContainer, bioContainer, statsContainer;
@synthesize damagePointsLabel, missileSpeedLabel, intelligencePointsLabel, attackRangeLabel, attackDurationLabel, heroNameLabel, armorPointsLabel, castDurationLabel, movementSpeedPointsLabel, factionImageView,roleLabel,primaryAttributeImageView, agilityPointsLabel, sightRangeLabel, strengthPointsLabel, turnRateLabel;
@synthesize scrollView, bioLabel, bioTextView;
@synthesize statsHeaderLabel;
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

    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.heroNameLabel.text = hero.name;

    self.heroImageView.image = [UIImage imageWithContentsOfFile:hero.detailImgPath];
    self.heroImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.heroImageView.layer.shadowOffset = CGSizeMake(2, 2);
    self.heroImageView.layer.shadowOpacity = 1;
    self.heroImageView.layer.shadowRadius = 5.0;
 
    
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
    
    self.bioLabel.text = hero.bio;
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(self.bioLabel.frame.size.width, FLT_MAX);
    
    CGSize expectedLabelSize = [hero.bio sizeWithFont:self.bioLabel.font constrainedToSize:maximumLabelSize lineBreakMode:self.bioLabel.lineBreakMode];   
    
    //adjust the label the the new height.
    CGRect newFrame = self.bioLabel.frame;
    newFrame.size.height = expectedLabelSize.height + 20;
    self.bioLabel.frame = newFrame;

    //configure scroll view based on dynamic properties of hero
    [self configureScrollviewLayout];
    
    //Configure Scrollview
    [self.scrollView setContentSize:CGSizeMake(0, self.statsContainer.frame.origin.y + self.statsContainer.frame.size.height+100)];


}

# pragma mark - Screen Configuration


- (void)configureScrollviewLayout {
    //First the biography container
    int bioContainerHeight = self.bioLabel.frame.size.height + 40; //40 for padding
    self.bioContainer.frame = CGRectMake(self.bioContainer.frame.origin.x,
                                         self.bioContainer.frame.origin.y,
                                         self.bioContainer.frame.size.width,
                                         bioContainerHeight);
    //Secondly the stats header and container
    int bioContainerEnd = self.bioContainer.frame.origin.y + self.bioContainer.frame.size.height;
    self.statsHeaderLabel.frame = CGRectMake(self.statsHeaderLabel.frame.origin.x,
                                             bioContainerEnd + PADDING,
                                             self.statsHeaderLabel.frame.size.width, 
                                             self.statsHeaderLabel.frame.size.height);
    int statsHeaderEnd = self.statsHeaderLabel.frame.origin.y + self.statsHeaderLabel.frame.size.height;
    self.statsContainer.frame = CGRectMake(self.statsContainer.frame.origin.x,
                                           statsHeaderEnd + PADDING,
                                           self.statsContainer.frame.size.width, 
                                           self.statsContainer.frame.size.height);
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
