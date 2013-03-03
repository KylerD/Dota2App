//
//  Hero+DAO.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "Hero+DAO.h"
//#import "StackMob.h"
#import "Ability+DAO.h"
#import "Nickname+DAO.h"
#import "Role.h"
#import "Role+DAO.h"
#import "Nickname.h"

@implementation Hero (DAO)

+ (Hero *)heroFromSMDictionary:(NSDictionary*)heroDictionary {
    
    NSString *heroName = [self interpretValue:[heroDictionary valueForKey:@"name"]];
    
    Hero* hero = [Hero readOrCreateObjectWithParamterName:@"name" andValue:heroName];
    
    for (NSString * key in [heroDictionary allKeys]) {
        
        if([key isEqualToString:@"detail_img_path"]){
            //TODO: CHANGE/REMOVE
        } else if([key isEqualToString:@"roles"]){

            NSArray * roles = [heroDictionary valueForKey:key];
            
            NSMutableSet * roleObjects = [NSMutableSet set];
            
            for (NSDictionary * roleDictionary in roles) {
                [roleObjects addObject:[Role roleFromSMDictionary:roleDictionary]];
            }
            
            if ([roleObjects anyObject]) {
                [hero addRoles:roleObjects];
            }
            
            
        } else  if([key isEqualToString:@"abilities"]){

            NSArray * abilities = [heroDictionary valueForKey:key];
            
            NSMutableSet * abiltiyObjects = [NSMutableSet set];
            
            for (NSDictionary * abilityDictionary in abilities) {
                [abiltiyObjects addObject:[Ability abilityFromSMDictionary:abilityDictionary]];
            }
            
            if ([abiltiyObjects anyObject]) {
                [hero addAbilities:abiltiyObjects];
            }
            
        } else if([key isEqualToString:@"nicknames"]){
            
            NSArray * nicks = [heroDictionary valueForKey:key];
            
            NSMutableSet * nickObjects = [NSMutableSet set];
            
            for (NSDictionary * nickDictionary in nicks) {
                [nickObjects addObject:[Nickname nicknameFromSMDictionary:nickDictionary]];
            }
            
            if ([nickObjects anyObject]) {
                [hero addNicknames:nickObjects];
            }
        } else {
            [hero setValue:[heroDictionary valueForKey:key] forKey:key];
        }
        
    }
    
    return hero;
}

+ (Hero *)heroFromDictionary:(NSDictionary*)heroDictionary {
    NSString *heroName = [self interpretValue:[heroDictionary valueForKey:@"name"]];
    
    Hero* hero = [Hero readOrCreateObjectWithParamterName:@"name" andValue:heroName];
    
    //TODO: Map dict to values..
    NSString *attributeMultiCase = [self interpretValue:[heroDictionary valueForKey:@"primary"]];
    
    NSString *attributeLowerCase = [attributeMultiCase lowercaseString];
    /* create the new string */
    NSString *attribute = [attributeLowerCase capitalizedString];
    
    hero.primary_attribute = attribute;
    
    if(!hero.primary_attribute){
        hero.primary_attribute = @"Unknown";
    }
    
    //images
    
    NSString *iconImagePath = [NSString stringWithFormat:@"%@_icon.png",heroName];
    hero.icon_image = iconImagePath;
    
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    hero.bio = [self interpretValue:[heroDictionary valueForKey:@"bio"]];
    hero.armour = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"amour"]]];
    hero.str_points = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"str"]]];
    hero.agil_gain = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"agiGain"]]];
    hero.attack_range = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"range"]]];
    hero.sight = [self interpretValue:[heroDictionary valueForKey:@"sight"]];
    hero.damage = [self interpretValue:[heroDictionary valueForKey:@"attack"]];
    hero.faction = [self interpretValue:[heroDictionary valueForKey:@"faction"]];
    hero.attack_type = [self interpretValue:[heroDictionary valueForKey:@"attackMode"]];
    if(!hero.faction){
        hero.faction = @"Unknown";
    }
    
    //Image download and cache
    NSString *imgUrl = [self interpretValue:[heroDictionary valueForKey:@"portraitUrl"]];
    hero.detail_img_url = imgUrl;
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString  *downloadedfilePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, heroName];
    NSString *bundleImagePath = [[NSBundle mainBundle]
                                 pathForResource:heroName
                                 ofType:@"png"];
    
    
    if ([fileManager fileExistsAtPath:bundleImagePath]) {//Check bundle for image
        hero.detail_img_url= bundleImagePath;
    } else if ([fileManager fileExistsAtPath:downloadedfilePath]) { //check if previously downloaded
        hero.detail_img_url = downloadedfilePath;
    } else {
        //Download it!
        NSURL  *url = [NSURL URLWithString:imgUrl];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        //If there's an internet connection grab url image
        if (urlData) {
            [urlData writeToFile:downloadedfilePath atomically:YES];
            hero.detail_img_url = downloadedfilePath;
        }
    }
    
    hero.str_gain = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"strGain"]]];
    hero.agil_points = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"agi"]]];
    hero.url = [self interpretValue:[heroDictionary valueForKey:@"url"]];
    hero.missile_speed = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"missileSpeed"]]];
    hero.intel_points = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"int"]]];
    hero.intel_gain = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"intGain"]]];
    
    hero.ms = [nf numberFromString:[self interpretValue:[heroDictionary valueForKey:@"ms"]]];
    
    hero.name = heroName;
    //TODO: Create preprocessed dictionary of Nicknames and use it to create the nicknames, search mechanisim tested and works..
    //    if([heroName isEqualToString:@"Crystal Maiden"]){
    //        Nickname * test = [Nickname createObject];
    //        test.name = @"cm";
    //        [hero addNicknamesObject:test];
    //    }
    
    //ROLES
    NSArray * roleStrings =  [heroDictionary valueForKey:@"roles"];
    
    for (NSString * roleString in  roleStrings) {
        Role * r = [Role createOrFindRole:roleString];
        [hero addRolesObject:r];
    }
    
    //Abilities
    NSArray *abilities = [heroDictionary valueForKey:@"abilities"];
    for (int i = 0; i < [abilities count]; i++) {
        NSDictionary *abilityDictionary = [abilities objectAtIndex:i];
        Ability *ability = [Ability abilityFromDictionary:abilityDictionary forHero:hero];
        ability.hero = hero;
    }
    
    //Inital Nickname
    NSString *sep = @" -";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:sep];
    NSArray *wordsInHeroName=[hero.name componentsSeparatedByCharactersInSet:set];
    
    NSMutableString * simpleNickname = [NSMutableString string];
    
    if([wordsInHeroName count]>1){
        
        for (NSString * word in wordsInHeroName) {
            NSString * firstChar = [word substringToIndex:1];
            [simpleNickname appendFormat:@"%@",firstChar];
        }
        
        Nickname * nick = [Nickname createObject];
        nick.name = simpleNickname;
        [hero addNicknamesObject:nick];
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
