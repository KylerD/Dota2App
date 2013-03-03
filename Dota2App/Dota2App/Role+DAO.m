//
//  Role+DAO.m
//  Dota2App
//
//  Created by Luke McNeice on 22/12/2012.
//
//

#import "Role+DAO.h"
#import "Role.h"
#import "NSManagedObject+CRUD.h"

@implementation Role (DAO)

+ (Role*)roleFromSMDictionary:(NSDictionary*)roleDictionary {
    
    NSString *uniqueName = [roleDictionary valueForKey:@"role_name"];
    
    Role* role = [Role readOrCreateObjectWithParamterName:@"role_name" andValue:uniqueName];
    
    for (NSString * key in [roleDictionary allKeys]) {
        
        if([key isEqualToString:@"heros"]){
            continue;
        } else {
            [role setValue:[roleDictionary valueForKey:key] forKey:key];
        }
        
    }
    
    return role;
}

+ (Role*)createOrFindRole:(NSString*)roleString {
    
    Role * r;
    r = [Role readOrCreateObjectWithParamterName:@"roleName" andValue:roleString];
    
    if(!r){
        r =  [Role createObject];
        r.role_name = roleString;
        r.role_image = [NSString stringWithFormat:@"%@.%@",roleString,@"png"];
    }
    
    return r;
}

@end
