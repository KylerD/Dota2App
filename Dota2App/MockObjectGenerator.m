//
//  MockObjectGenerator.m
//  Dota2App
//
//  Created by Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MockObjectGenerator.h"

#import "AppDelegate.h"
#import "Ability.h"

@interface MockObjectGenerator()
- (void)createHero;
@end

@implementation MockObjectGenerator

- (id)init {
    if (self = [super init]) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        context = delegate.managedObjectContext;
        // Mock Hero Data
        heroNames = [[NSArray alloc] initWithObjects:@"EarthShaker", @"Sven", @"Tiny", @"Huskar", @"Magnus", @"Ug", @"Juggernaut", @"Gyrocopter",  nil];
        heroBiographies = [[NSArray alloc] initWithObjects:@"This guy, well what else is there to say about this guy, he wins, all the time.", @"In west philadalphia born n' raised, on the playground is where he spent most of his days", @"Make my damn microphone", @"Another random biography nobody will ever see", @"He's always wondered if there's more to life than being really, really, really, ridiciously good looking", @"I DONT EVEN KNOW", @"Let's get down to businesss, to defeat, the hunssss, houh!", @"WHY'D THEY SEND ME DAUGHTERS, WHEN I ASKED, FOR SONS!", nil];
        
        heroImages = [[NSArray alloc] initWithObjects:@"AncientApparition.png", @"BountyHunter.png", @"Clockwerk.png", @"Disruptor.png", @"Invoker.png", @"NyxAssassin.png", @"ShadowDemon.png", @"Sniper.png", nil];
        heroIcons = [[NSArray alloc] initWithObjects:@"axe_icon.png", @"Darkterror_icon.png", @"tiny_icon.png", nil];
        
        //Mock Ability Data
        abilityNames = [[NSArray alloc] initWithObjects:@"Meat Hook", @"Burrowstrike", @"Sand Storm", @"Epicenter", @"Thunder Clap", @"Drunken Haze", nil];
        abilityNotes = [[NSArray alloc] initWithObjects:@"Slams the ground, dealing damage", @"Drenches an enemy unit in damage", @"Gives a chance to avoid attacks", @"Gives a change to critically hit", @"Summons a Giant Stu to bewilder your enemies", @"Summons a procastinating Luke to distract all enemy team members", nil];
        abilityImages = [[NSArray alloc] initWithObjects:@"abilityOne.jpeg", @"abilityTwo.jpeg", @"abilityThree.jpeg", @"abilityFour.jpeg", @"abilityFive.jpeg", nil];
        abilityDamage = [[NSArray alloc] initWithObjects:@"Magical", @"Physical", @"None", nil];
        abilityAffects = [[NSArray alloc] initWithObjects:@"Allies", @"Enemies", @"Self", nil];
        abilityTypes = [[NSArray alloc] initWithObjects:@"No target", @"Target Point", @"Passive", nil];
    }
    
    return self;
}

#pragma mark - Creators

- (void)createHero {
    Hero *hero =  [NSEntityDescription insertNewObjectForEntityForName:@"Hero" inManagedObjectContext:context];
    int randomNameIndex = arc4random() % [heroNames count];
    int randomBioIndex = arc4random() % [heroBiographies count];
    int randomImageIndex = arc4random() % [heroImages count];
    int randomIconIndex = arc4random() % [heroIcons count];
    //Basic details
    hero.name = [heroNames objectAtIndex:randomNameIndex];
    hero.bio = [heroBiographies objectAtIndex:randomBioIndex];
    hero.detailImage = [heroImages objectAtIndex:randomImageIndex];
    hero.iconImage = [heroIcons objectAtIndex:randomIconIndex];
    //Stats
    int strengthPoint = (arc4random() % 15) + 10;
    int strengthExtensionPoint = (arc4random() % 5) + 1;
    int agilityPoint = (arc4random() % 15) + 10;
    int agilityExtensionPoint = (arc4random() % 5) + 1;
    int intPoint = (arc4random() % 15) + 10;
    int intExtensionPoint = (arc4random() % 5) + 1;
    NSString *strength = [NSString stringWithFormat:@"%i + %i", strengthPoint, strengthExtensionPoint];
    NSString *agility = [NSString stringWithFormat:@"%i + %i", agilityPoint, agilityExtensionPoint];
    NSString *intelligence = [NSString stringWithFormat:@"%i + %i", intPoint, intExtensionPoint];
    
    hero.strengthPoints = strength;
    hero.agilityPoints = agility;
    hero.intelligencePoints = intelligence;
    
    int typeChange = arc4random() % 2;
    if (typeChange == 1) {
        hero.faction = @"Radiant";
    } else {
        hero.faction = @"Dire";
    }
    
    int specChange = arc4random() % 3;
    switch (specChange) {
        case 0:
            hero.attribute= @"Strength";
            break;
        case 1:
            hero.attribute = @"Agility";
            break;
        case 2:
            hero.attribute = @"Intelligence";
            break;
    }
    
    //Generate 4 abilities for the hero
    for (int abilities = 0; abilities < 4; abilities++) {
        [self generateAbilityForHero:hero];
    }
      
}

- (void)generateAbilityForHero: (Hero *)hero {
    Ability *ability =  [NSEntityDescription insertNewObjectForEntityForName:@"Ability" inManagedObjectContext:context];
    //get random indexes
    int randomNameIndex = arc4random() % [abilityNames count];
    int randomNoteIndex = arc4random() % [abilityNotes count];
    int randomImageIndex = arc4random() % [abilityImages count];
    int randomDamageTypeIndex = arc4random() % [abilityDamage count];
    int randomAffectsIndex = arc4random() % [abilityAffects count];
    int randomTypeIndex = arc4random() % [abilityTypes count];
    
    //set attributes
    ability.name = [abilityNames objectAtIndex:randomNameIndex];
    ability.notes = [abilityNotes objectAtIndex:randomNoteIndex];
    ability.imagePath = [abilityImages objectAtIndex:randomImageIndex];
    ability.affects = [abilityAffects objectAtIndex:randomAffectsIndex];
    ability.ability = [abilityTypes objectAtIndex:randomTypeIndex];
    ability.damage = [abilityDamage objectAtIndex:randomDamageTypeIndex];
    //sets up the relationship
    ability.isAbilityOf = hero;
    
}

#pragma mark - Generators

- (void)generateRandomHeros {
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Hero"];
    NSUInteger count = [context countForFetchRequest:fetch error:nil];
    if (count == 0) {
        for (int i = 0; i < 10; i++) {
            [self createHero];
        }
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}



@end
