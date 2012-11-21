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
    NSData * heroesJSONData = [self getJSONData];
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    NSArray * heroesJSON = [self getJSONDictionary:heroesJSONData];
    BOOL success = [self createHeroes:heroesJSON];

    if (success) {
        NSError *error;
        
        if (![del.managedObjectContext save:&error]) {
            NSLog(@"Save no work");
        } else {
            NSLog(@"Save succesful!");
        }
    }

    
    return success;

}

- (NSData*)getJSONData {
    return [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heroData" ofType:@"json"]];
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
    
    int failCount = 1;
    
    for (NSDictionary * heroJSON in heroesJSON) {
        if(![self createHero:heroJSON]){
            failCount = 0;
            NSLog(@"Failed to create Hero for:/n %@",heroJSON);
        }
    }

    return (BOOL)failCount;
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

- (BOOL)createHero:(NSDictionary*)heroJSON{
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
