//
//  Hero+DAO.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "Hero+DAO.h"

@implementation Hero (DAO)
+ (Hero*)heroFromDictionary:(NSDictionary*)heroDictionary{
    
   // NSLog(@"Creating Hero with Dictionary:%@",heroDictionary);
    
    Hero* hero = [Hero createObject];
    
    //TODO: Map dict to values..
    hero.attribute = [self interpretValue:[heroDictionary valueForKey:@"primary attribute"]];
    
    if(!hero.attribute){
        hero.attribute =@"Unkown";
    }
    
    hero.bio = [self interpretValue:[heroDictionary valueForKey:@"lore"]];
    hero.detailImage = @"";
    hero.faction = [self interpretValue:[heroDictionary valueForKey:@"faction"]];
    hero.iconImage = @"";
    hero.name = [self interpretValue:[heroDictionary valueForKey:@"name"]];
    //More
    
    return hero;
}

+ (id)interpretValue:(id)value{
    
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
