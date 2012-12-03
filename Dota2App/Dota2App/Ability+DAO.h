//
//  Ability+DAO.h
//  Dota2App
//
//  Created by Kyle Davidson on 03/12/2012.
//
//

#import "Ability.h"

@interface Ability (DAO)

+ (Ability *)abilityFromDictionary:(NSDictionary*)abilityDictionary;
+ (id)interpretValue:(id)value;

@end
