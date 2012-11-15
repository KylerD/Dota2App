//
//  MockObjectGenerator.m
//  Dota2App
//
//  Created by Jamie O'Hara on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MockObjectGenerator.h"

#import "AppDelegate.h"

@interface MockObjectGenerator()
- (void)createHero;
@end

@implementation MockObjectGenerator

- (id)init {
    if (self = [super init]) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        context = delegate.managedObjectContext;
        
        heroNames = [[NSArray alloc] initWithObjects:@"EarthShaker", @"Sven", @"Tiny", @"Huskar", @"Magnus", @"Ug", @"Juggernaut", @"Gyrocopter",  nil];
        heroBiographies = [[NSArray alloc] initWithObjects:@"This guy, well what else is there to say about this guy, he wins, all the time.", @"In west philadalphia born n' raised, on the playground is where he spent most of his days", @"Make my damn microphone", @"Another random biography nobody will ever see", @"He's always wondered if there's more to life than being really, really, really, ridiciously good looking", @"I DONT EVEN KNOW", @"Let's get down to businesss, to defeat, the hunssss, houh!", @"WHY'D THEY SEND ME DAUGHTERS, WHEN I ASKED, FOR SONS!", nil];
        
        heroImages = [[NSArray alloc] initWithObjects:@"AncientApparition.png", @"BountyHunter.png", @"Clockwerk.png", @"Disruptor.png", @"Invoker.png", @"NyxAssassin.png", @"ShadowDemon.png", @"Sniper.png", nil];
        heroIcons = [[NSArray alloc] initWithObjects:@"axe_icon.png", @"Darkterror_icon.png", @"tiny_icon.png", nil];
        
    }
    
    return self;
}

#pragma mark - Generators

- (void)createHero {
    Hero *hero =  [NSEntityDescription insertNewObjectForEntityForName:@"Hero" inManagedObjectContext:context];
    int randomNameIndex = arc4random() % [heroNames count];
    int randomBioIndex = arc4random() % [heroBiographies count];
    int randomImageIndex = arc4random() % [heroImages count];
    int randomIconIndex = arc4random() % [heroIcons count];
    
    hero.name = [heroNames objectAtIndex:randomNameIndex];
    hero.bio = [heroBiographies objectAtIndex:randomBioIndex];
    hero.detailImage = [heroImages objectAtIndex:randomImageIndex];
    hero.iconImage = [heroIcons objectAtIndex:randomIconIndex];
    
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
      
}

- (void)generateRandomHeros {
    
    for (int i = 0; i < 10; i++) {
        [self createHero];
    }

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}
@end
