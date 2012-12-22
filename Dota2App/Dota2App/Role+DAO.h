//
//  Role+DAO.h
//  Dota2App
//
//  Created by Luke McNeice on 22/12/2012.
//
//

#import "Role.h"

@interface Role (DAO)
+ (Role*)createOrFindRole:(NSString*)roleString;
@end
