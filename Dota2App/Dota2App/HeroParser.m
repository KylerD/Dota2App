//
//  HeroParser.m
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "HeroParser.h"

@implementation HeroParser

-(void)parse{
    NSData * heroJSONData = [self getJSONData];
    NSDictionary * heroJSON = [self getJSONDictionary:heroJSONData];
}


-(NSData*)getJSONData {
    return [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heroData" ofType:@"json"]];
}

- (NSDictionary*)getJSONDictionary:(NSData *)responseData {
    NSError* error;
    NSDictionary * heroJSON = [NSJSONSerialization
                               JSONObjectWithData:responseData //1
                               options:kNilOptions
                               error:&error];
    
    if(![[heroJSON allKeys] lastObject]){
        NSLog(@"Error parsing JSON: %@",error);
    }
    
    return heroJSON;
}

-(BOOL)createHeroObjects{
    //TODO: Create Core data objects
    return YES;
}

@end
