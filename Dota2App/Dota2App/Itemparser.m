//
//  Itemparser.m
//  Dota2App
//
//  Created by Luke McNeice on 26/12/2012.
//
//

#import "Itemparser.h"
#import "Item+DAO.h"

@implementation Itemparser



- (BOOL)parse {
    
    //Note: you can comment this whole method out and just return YES after the first run to stop the massive start time.
    NSData * itemsJSONData = [self getJSONData];
    NSDictionary * itemsJSONDict = [self getJSONDictionary:itemsJSONData];
    BOOL success = [self createItems:itemsJSONDict];
    //[Item mapItemComponents];//mapping done laziliy
    [Item saveDatabase];
    
    return success;
}

- (NSData*)getJSONData {
    return [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"item" ofType:@"json"]];
}

- (NSDictionary*)getJSONDictionary:(NSData *)responseData {
    
    NSError* error;
    NSDictionary * itemJSON = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    
    NSDictionary * itemJSONCorrectedDict = [itemJSON valueForKey:@"itemdata"];
    
    if([itemJSONCorrectedDict allKeys]==0){
        NSLog(@"Error parsing JSON: %@",error);
    }
    
    return itemJSONCorrectedDict;
}

-(BOOL)createItems:(NSDictionary*)itemsJSONDict {
    
    int failCount = 0;
    
    NSArray * itemIDs  = [itemsJSONDict allKeys];
    
    for (NSString * key in itemIDs) {
        
        NSDictionary * itemDict  = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObject:[itemsJSONDict valueForKey:key]] forKeys:[NSArray arrayWithObject:key]];
        
        
        if(![self createItem:itemDict]){
            failCount++;
            NSLog(@"Failed to create Hero for:/n %@",itemsJSONDict);
        }
    }
    
    return !(BOOL)failCount;
}

- (BOOL)createItem:(NSDictionary*)itemJSON {
    [Item createOrFindItem:itemJSON];
    return YES;
}

@end
