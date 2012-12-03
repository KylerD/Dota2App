//
//  Ability+DAO.m
//  Dota2App
//
//  Created by Kyle Davidson on 03/12/2012.
//
//

#import "Ability+DAO.h"

@implementation Ability (DAO)

+ (Ability *)abilityFromDictionary:(NSDictionary*)abilityDictionary {
    NSString *abilityName = [self interpretValue:[abilityDictionary valueForKey:@"name"]];
    Ability *ability = [Ability readOrCreateObjectWithParamterName:@"name" andValue:abilityName];
    ability.name = abilityName;
    ability.notes = [self interpretValue:[abilityDictionary valueForKey:@"description"]];
    ability.lore = [self interpretValue:[abilityDictionary valueForKey:@"lore"]];
    ability.videoUrl = [self interpretValue:[abilityDictionary valueForKey:@"videoUrl"]];
    ability.imgUrl = [self interpretValue:[abilityDictionary valueForKey:@"imgUrl"]];
    
    return ability;
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
