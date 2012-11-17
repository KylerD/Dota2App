//
//  HeroParser.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "HeroParser.h"

#import "Hero.h"
#import "Ability.h"

@implementation HeroParser

- (BOOL)parse {
    NSData * heroJSONData = [self getJSONData];
    NSDictionary * heroJSON = [self getJSONDictionary:heroJSONData];
    BOOL success = [self createHeroObjects:heroJSON];
    return success;
}


- (NSData*)getJSONData {
    return [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heroData" ofType:@"json"]];
}

- (NSDictionary*)getJSONDictionary:(NSData *)responseData {
    NSError* error;
    NSDictionary * heroJSON = [NSJSONSerialization
                               JSONObjectWithData:responseData
                               options:kNilOptions
                               error:&error];
    
    if(![[heroJSON allKeys] lastObject]){
        NSLog(@"Error parsing JSON: %@",error);
    }
    
    return heroJSON;
}


- (BOOL)createHeroObjects:(NSDictionary*)heroJSON{
    //TODO: Create Core data objects
    
    [Hero createObject];
    
    
    return YES;
}

@end
