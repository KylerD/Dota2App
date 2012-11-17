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
    Hero* hero = [Hero createObject];
    
    //TODO: Map dict to values..
    hero.attribute = @"";
    hero.bio = @"";
    hero.detailImage = @"";
    hero.faction = @"";
    hero.iconImage = @"";
    hero.name = @"";
    //More
    
    return hero;
}
@end
