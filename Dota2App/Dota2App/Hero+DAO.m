//
//  Hero+DAO.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "Hero+DAO.h"
#import "StackMob.h"
#import "Ability+DAO.h"

@implementation Hero (DAO)

+ (Hero *)heroFromDictionary:(NSDictionary*)heroDictionary {
    NSString *heroName = [self interpretValue:[heroDictionary valueForKey:@"name"]];
    
   // NSLog(@"Creating Hero with Dictionary:%@",heroDictionary);
    
    Hero* hero = [Hero readOrCreateObjectWithParamterName:@"name" andValue:heroName];
    
    //TODO: Map dict to values..
    NSString *attributeMultiCase = [self interpretValue:[heroDictionary valueForKey:@"primary attribute"]];

    NSString *attributeLowerCase = [attributeMultiCase lowercaseString];
    /* create the new string */
    NSString *attribute = [attributeLowerCase capitalizedString];
    
    hero.primaryAttribute = attribute;
    
    if(!hero.primaryAttribute){
        hero.primaryAttribute = @"Unknown";
    }
    
    //images
    NSString *detailImagePath = [NSString stringWithFormat:@"%@.png",heroName];
    NSString *iconImagePath = [NSString stringWithFormat:@"%@_icon.png",heroName];
    hero.detailImage = detailImagePath;
    hero.iconImage = iconImagePath;
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    hero.bio = [self interpretValue:[heroDictionary valueForKey:@"bio"]];
    hero.armour = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"amour"]]];
    hero.strPoints = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"str"]]];
    hero.agilGain = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"agiGain"]]];
    hero.attackRange = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"range"]]];
    
    hero.faction = [self interpretValue:[heroDictionary valueForKey:@"faction"]];
    if(!hero.faction){
        hero.faction = @"Unknown";
    }
    
    //hero.roles = [self interpretValue:[heroDictionary valueForKey:@"roles"]];
    //hero.attackMode = [self interpretValue:[heroDictionary valueForKey:@"roles"]];
    //hero.url = [self interpretValue:[heroDictionary valueForKey:@"url"]];
    hero.missileSpeed = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"missileSpeed"]]];
    hero.intelPoints = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"int"]]];
    //hero.damage = [self interpretValue:[heroDictionary valueForKey:@"attack"]];
    hero.intelGain = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"intGain"]]];
    //hero.sight = [self interpretValue:[heroDictionary valueForKey:@"sight"]];
    hero.ms = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"ms"]]];
    
    
    
    
    hero.name = heroName;
    //More
    
    NSArray *abilities = [heroDictionary valueForKey:@"abilities"];
    for (int i = 0; i < [abilities count]; i++) {
        NSDictionary *abilityDictionary = [abilities objectAtIndex:i];
        Ability *ability = [Ability abilityFromDictionary:abilityDictionary];
        ability.hero = hero;
    }
    
    return hero;
}


+ (id)interpretValue:(id)value {
    
    if([value isKindOfClass:[NSString class]]){
        return value;
    } else if([value isKindOfClass:[NSArray class]]){
        return [value objectAtIndex:0];
    } else {
        NSLog(@"Object %@ Of type %@ can not be interpreted",value,[value class]);
        return nil;
    }
}

@end
