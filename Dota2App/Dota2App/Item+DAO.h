//
//  Item+DAO.h
//  Dota2App
//
//  Created by Luke McNeice on 26/12/2012.
//
//

#import "Item.h"

@interface Item (DAO)
+ (Item*)createOrFindItem:(NSDictionary*)itemDictionary;
- (void)mapItemComponents;
@end
