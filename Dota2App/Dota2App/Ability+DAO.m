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
    
    //Image download and cache
    NSString *imgUrl = [self interpretValue:[abilityDictionary valueForKey:@"imgUrl"]];
    ability.imgUrl = imgUrl;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, abilityName];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        NSURL  *url = [NSURL URLWithString:imgUrl];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if (urlData) {
            [urlData writeToFile:filePath atomically:YES];
            ability.imagePath = filePath;
        } else {    //Else use bundled image
            NSString *bundleImageName = [NSString stringWithFormat:@"%@.png", ability.name];
            ability.imagePath = bundleImageName;
            
        }
    }
    
    NSDictionary * dynamicDict = [abilityDictionary valueForKey:@"dynamic"];
    
    //Get Ability Type..
    
    NSString *abiltiyTypeMixedString = [dynamicDict valueForKey:@"Ability"];
    
    NSMutableSet * abilityTypes = [NSMutableSet setWithArray:[abiltiyTypeMixedString componentsSeparatedByString:@", "]];
    
    
    NSMutableSet * abilitiyTypesToRemove = [NSMutableSet set];
    
    for (NSString * abilityType in abilityTypes) {
        
        NSString * cleanedAbilityType = abilityType;
        
        if([cleanedAbilityType isEqualToString:@"Toggle"]){
            ability.isToggle = [NSNumber numberWithBool:YES];
            [abilitiyTypesToRemove addObject:cleanedAbilityType];
        } else if([cleanedAbilityType isEqualToString:@"Aura"]){
            ability.isAura = [NSNumber numberWithBool:YES];
             [abilitiyTypesToRemove addObject:cleanedAbilityType];
        } else if([cleanedAbilityType isEqualToString:@"Auto-Cast"]){
            ability.isAutoCast = [NSNumber numberWithBool:YES];
             [abilitiyTypesToRemove addObject:cleanedAbilityType];
        } else if ([abilityType isEqualToString:@"Passive"]) {
            ability.isPassive = [NSNumber numberWithBool:YES];
            [abilitiyTypesToRemove addObject:cleanedAbilityType];
        } else if ([abilityType isEqualToString:@"Channeled"]) {
            ability.isChanneled = [NSNumber numberWithBool:YES];
            [abilitiyTypesToRemove addObject:cleanedAbilityType];
        }

    }
    
    [abilityTypes minusSet:abilitiyTypesToRemove];
    
    heroAbilityType type = heroAbilityUnknownType;
    
    if([abilityTypes count] == 1){
        
        NSString * abilityType = [abilityTypes anyObject];
        
        if ([abilityType isEqualToString:@"Unit Target"]) {
            type = heroAbilityUnitTargetType;
        } else if ([abilityType isEqualToString:@"No Target"]) {
                type = heroAbilityNoTargetType;
        } else if ([abilityType isEqualToString:@"Point Target"]) {
            type = heroAbilityPointTargetType;
        }
        
    } else {
        //NSLog(@"Multiple Types found: [%@], assuming point and unit!",abilityTypes);
        type = heroAbilityPointAndUnitTargetType;
    }
    
    
    ability.type = [NSNumber numberWithInt:type];
    
    //Store Dynamic Values as NSDATA    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dynamicDict
                                                       options:0
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    ability.dynamic = jsonString;
    
    NSArray * manaCost = [abilityDictionary valueForKey:@"mana"];
    
    NSMutableString * sb = [NSMutableString string];
    
    for (NSString * mp in manaCost) {
        [sb appendFormat:@"%@ / ",mp];
    }
    
    if(![sb isEqualToString:@""]){
        [sb deleteCharactersInRange:NSMakeRange(sb.length-3,3)];
    }
    
    ability.mc = [sb copy];
    sb=nil; sb = [NSMutableString string]; //Reusing...
    
    NSArray * coolDown = [abilityDictionary valueForKey:@"cooldown"];
    
    for (NSString * cd in coolDown) {
        [sb appendFormat:@"%@ / ",cd];
    }
    
    if(![sb isEqualToString:@""]){
        [sb deleteCharactersInRange:NSMakeRange(sb.length-3,3)];
    }
    
    ability.cd = sb;
    
    ability.index = [abilityDictionary valueForKey:@"index"];
    
 
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
