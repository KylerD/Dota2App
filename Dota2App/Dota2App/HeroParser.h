//
//  HeroParser.h
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import <Foundation/Foundation.h>

@interface HeroParser : NSObject
- (BOOL)parse;
-(BOOL)createHeroes:(NSArray*)heroesJSON;
- (NSArray*)getJSONDictionary:(NSData *)responseData;
- (NSData*)getJSONData;
- (BOOL)createHero:(NSDictionary*)heroJSON;
@end
