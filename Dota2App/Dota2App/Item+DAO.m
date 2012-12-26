//
//  Item+DAO.m
//  Dota2App
//
//  Created by Luke McNeice on 26/12/2012.
//
//

#import "Item+DAO.h"
#import "Item.h"
#import "NSManagedObject+CRUD.h"

@implementation Item (DAO)


//Method for lazy loading item dependacies (components), this method should be called
- (void)mapItemComponents{
    
    if([self.components count]==0){
    NSArray * comps = [self.compString componentsSeparatedByString:@","];
    
    
    for (NSString * comp in comps) {
        Item * compItem = [Item readObjectWithParamterName:@"itemID" andValue:comp];
        [self addComponentsObject:compItem];
    }
    
    [Item saveDatabase];
    }
    
}



+ (Item*)createOrFindItem:(NSDictionary*)topLevelItemDictionary{
    
    Item * i;
    
    NSString * itemID = [[topLevelItemDictionary allKeys] lastObject];
    
    NSDictionary * itemDictionary = [topLevelItemDictionary valueForKey:itemID];
    
    i = [Item readObjectWithParamterName:@"itemID" andValue:itemID];
    
    if(!i){
        i =  [Item createObject];
        
        i.itemID = itemID;
        i.name = [itemDictionary valueForKey:@"dname"];
        i.desc = [itemDictionary valueForKey:@"desc"];
        i.imgName = [itemDictionary valueForKey:@"img"];
        i.attribString = [itemDictionary valueForKey:@"attrib"];
        i.lore = [itemDictionary valueForKey:@"lore"];
        
        id tryType = [itemDictionary valueForKey:@"qual"];
        if([tryType isKindOfClass:[NSString class]]){ 
            i.type = (NSString*)tryType;
        } else { //Fucking Shadow amulet
            i.type = @"component";
        }
        
        NSLog(@"Cost");
        i.cost = [NSNumber numberWithFloat:[[itemDictionary valueForKey:@"attrib"] floatValue]];
        NSLog(@"cd");
        i.coolDown = [NSNumber numberWithFloat:[[itemDictionary valueForKey:@"cd"] floatValue]];
        NSLog(@"mana");
        
        id tryMana = [NSNumber numberWithFloat:[[itemDictionary valueForKey:@"mc"] floatValue]];
        if([tryMana isKindOfClass:[NSNumber class]]){
            i.manaCost = tryMana;
        }
        
        NSLog(@"copms");
        NSArray * compArray  = [itemDictionary valueForKey:@"components"];
        if(compArray && ![compArray isKindOfClass:[NSNull class]]){ //Creating a transient prop for holding the item ID's (These items may not have been created yet!)
            
            NSMutableString * compArrayString = [NSMutableString string];
            
            for (NSString * comp in compArray) {
                [compArrayString appendFormat:@"%@,",comp];
            }
            
            [compArrayString deleteCharactersInRange:NSMakeRange(compArrayString.length-1,1)];
            i.compString = compArrayString;
        }
        NSLog(@"done");
    }
    
    return i;
}

@end
