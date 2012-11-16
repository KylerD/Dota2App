//
//  MockObjectGenerator.h
//  Dota2App
//
//  Created by Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"

@interface MockObjectGenerator : NSObject {
    // Used to Generate some random hero names/bios/images
    NSArray *heroNames;
    NSArray *heroBiographies;
    NSArray *heroImages;
    NSArray *heroIcons;
    //Used to generate some random Abilities
    NSArray *abilityNames;
    NSArray *abilityNotes;
    NSArray *abilityImages;
    NSArray *abilityTypes;
    NSArray *abilityAffects;
    NSArray *abilityDamage;
    //The managed object context
    NSManagedObjectContext *context;
}

- (void)generateRandomHeros;
/*
 * Used to set up 4 abilities related to a hero, a hero may have many abilities but each ability may have only one hero
 * @param Hero *hero: The hero for which the ability will be assigned
 */
- (void)generateAbilityForHero: (Hero *)hero;

@end
