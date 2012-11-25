//
//  Hero+DAO.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "Hero+DAO.h"
#import "StackMob.h"

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

    NSString *detailImagePath = [NSString stringWithFormat:@"%@.%@",heroName,@"png"];
    NSString *iconImagePath = [NSString stringWithFormat:@"%@_icon.%@",heroName,@"png"];
    
    hero.bio = [self interpretValue:[heroDictionary valueForKey:@"lore"]];
    hero.detailImage = detailImagePath;
    hero.faction = [self interpretValue:[heroDictionary valueForKey:@"faction"]];
    hero.iconImage = iconImagePath;
    hero.name = heroName;
    //More
    
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
