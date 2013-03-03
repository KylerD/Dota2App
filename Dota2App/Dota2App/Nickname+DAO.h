//
//  Nickname+DAO.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import "Nickname.h"

@interface Nickname (DAO)
+ (Nickname*)nicknameFromSMDictionary:(NSDictionary*)roleDictionary;
@end
