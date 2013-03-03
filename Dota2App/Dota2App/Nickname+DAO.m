//
//  Nickname+DAO.m
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import "Nickname+DAO.h"


@implementation Nickname (DAO)

+ (Nickname*)nicknameFromSMDictionary:(NSDictionary*)roleDictionary {
    
    NSString *uniqueName = [roleDictionary valueForKey:@"name"];
    
    Nickname* nick = [Nickname readOrCreateObjectWithParamterName:@"name" andValue:uniqueName];
    
    for (NSString * key in [roleDictionary allKeys]) {
        
        if([key isEqualToString:@"heroes"]){
            continue;
        } else {
            [nick setValue:[roleDictionary valueForKey:key] forKey:key];
        }
    
    }
    
    return nick;
}

@end
