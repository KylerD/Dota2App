//
//  Hero+DAO.h
//  Dota2App
//
//  Created by Luke McNeice on 17/11/2012.
//
//

#import "Hero.h"


@interface Hero (DAO)


+ (Hero*)heroFromDictionary:(NSDictionary*)heroDictionary;
+ (id)interpretValue:(id)value;

@end
