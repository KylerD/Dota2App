//
//  HeroParser.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "HeroParser.h"
#import "Hero.h"
#import "Hero+DAO.h"
#import "Ability.h"
#import "AppDelegate.h"

@implementation HeroParser

- (BOOL)parse {

    //Note: you can comment this whole method out and just return YES after the first run to stop the massive start time.
    NSData * heroesJSONData = [self getJSONData];
    NSArray * heroesJSON = [self getJSONDictionary:heroesJSONData];
    BOOL success = [self createHeroes:heroesJSON];
    
    [Hero saveDatabase];

    return success;
}

- (NSData*)getJSONData {
    return [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hero" ofType:@"json"]];
}

- (NSArray*)getJSONDictionary:(NSData *)responseData {
    
    NSError* error;
    NSArray * heroJSON = [NSJSONSerialization
                               JSONObjectWithData:responseData
                               options:kNilOptions
                               error:&error];
    
    if(![heroJSON lastObject]){
        NSLog(@"Error parsing JSON: %@",error);
    }
    
    return heroJSON;
}

-(BOOL)createHeroes:(NSArray*)heroesJSON {
    
    int failCount = 0;
    
    for (NSDictionary * heroJSON in heroesJSON) {
        if(![self createHero:heroJSON]){
            failCount++;
            NSLog(@"Failed to create Hero for:/n %@",heroJSON);
        }
    }

    return !(BOOL)failCount;
}

//- (BOOL)createAbilities:(NSArray*)abilitiesJSON {
//    //TODO: Create Core data objects
//    
//    int failCount = 0;
//    
//    for (NSDictionary * abilityJSON in abilitiesJSON) {
//        if(![self createAbility:abilityJSON]){
//            failCount++;
//            NSLog(@"Failed to create Ability for:/n %@",abilityJSON);
//        }
//    }
//    
//    return (BOOL)failCount;
//    
//    return YES;
//}

- (BOOL)createHero:(NSDictionary*)heroJSON {
    //TODO: Create Core data objects
    //NSLog(@"Creating Hero for JSON:/n%@",heroJSON);
    [Hero heroFromDictionary:heroJSON];
    return YES;
}

//- (BOOL)createAbility:(NSDictionary*)abilityJSON {
//    //TODO: Create Core data objects
//    NSLog(@"Creating Abilities for JSON:/n%@",abilityJSON);
//     [Hero heroFromDictionary:heroJSON];
//    return YES;
//}

@end
