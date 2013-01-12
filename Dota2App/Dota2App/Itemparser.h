//
//  Itemparser.h
//  Dota2App
//
//  Created by Luke McNeice on 26/12/2012.
//
//

#import <Foundation/Foundation.h>

@interface Itemparser : NSObject
- (BOOL)parse;
- (NSData*)getJSONData;
- (NSDictionary*)getJSONDictionary:(NSData *)responseData;
-(BOOL)createItems:(NSDictionary*)itemsJSONDict;
- (BOOL)createItem:(NSDictionary*)itemJSON;
@end
