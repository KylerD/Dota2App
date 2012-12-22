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


+ (Role*)createOrFindRole:(NSString*)roleString {
    
    Role * r;
    r = [Role readObjectWithParamterName:@"roleName" andValue:roleString];
    
    if(!r){
        r =  [Role createObject];
        r.roleName = roleString;
        r.roleImage = [NSString stringWithFormat:@"%@.%@",roleString,@"png"];
    }
    
    return r;
}

@end
