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
    NSArray * comps = [self.comp_string componentsSeparatedByString:@","];
    
    
    for (NSString * comp in comps) {
        Item * compItem = [Item readObjectWithParamterName:@"uniqueItemId" andValue:comp];
        if (compItem) {
            [self addComponentsObject:compItem];
        }
    }
    
    [Item saveDatabase];
    }
    
}



+ (Item*)createOrFindItem:(NSDictionary*)topLevelItemDictionary{
    
    Item * i;
    
    NSString * itemID = [[topLevelItemDictionary allKeys] lastObject];
    
    NSDictionary * itemDictionary = [topLevelItemDictionary valueForKey:itemID];
    NSString * itemName= [itemDictionary valueForKey:@"dname"];
    
    i = [Item readObjectWithParamterName:@"uniqueItemId" andValue:itemID];
    
    if(!i){
        
        NSString *itemPathPrefix = @"http://media.steampowered.com/apps/dota2/images/items/";
        
        NSRange range1 = [itemName rangeOfString:@"DOTA"];
        NSRange range2 = [itemName rangeOfString:@"Mysterious Spell Scroll"];
        if ((range1.location != NSNotFound) || (range2.location != NSNotFound)){
            return nil;
        }
        
        i =  [Item createObject];
        
        i.name = itemName;
        i.unique_item_id = itemID;
        i.desc = [itemDictionary valueForKey:@"desc"];
        //gets the web url for the image, prefix + imgName property of dict
        i.img_url = [NSString stringWithFormat:@"%@%@", itemPathPrefix, [itemDictionary valueForKey:@"img"]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        
        NSString  *downloadedfilePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, itemName];
        NSString *bundleImagePath = [[NSBundle mainBundle]
                                     pathForResource:itemName
                                     ofType:@"png"];
        
        
        if ([fileManager fileExistsAtPath:bundleImagePath]) {//Check bundle for image
            i.img_path = bundleImagePath;
        } else if ([fileManager fileExistsAtPath:downloadedfilePath]) { //check if previously downloaded
            i.img_path = downloadedfilePath;
        } else {
            //Download it!
            NSURL  *url = [NSURL URLWithString:i.img_url];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            //If there's an internet connection grab url image
            if (urlData) {
                [urlData writeToFile:downloadedfilePath atomically:YES];
                i.img_path = downloadedfilePath;
            }
        }

        i.attrib_string = [itemDictionary valueForKey:@"attrib"]; //gives raw HTML
        i.lore = [itemDictionary valueForKey:@"lore"];
        
        id tryType = [itemDictionary valueForKey:@"qual"];
        if([tryType isKindOfClass:[NSString class]]){ 
            i.type = (NSString*)tryType;
        } else { //Fucking Shadow amulet < Lmao
            i.type = @"component";
        }
        
        i.cost = [NSNumber numberWithFloat:[[itemDictionary valueForKey:@"cost"] floatValue]];
        i.cool_down = [NSNumber numberWithFloat:[[itemDictionary valueForKey:@"cd"] floatValue]];
        
        id tryMana = [NSNumber numberWithFloat:[[itemDictionary valueForKey:@"mc"] floatValue]];
        if([tryMana isKindOfClass:[NSNumber class]]){
            i.mana_cost = tryMana;
        }
                NSArray * compArray  = [itemDictionary valueForKey:@"components"];
        if(compArray && ![compArray isKindOfClass:[NSNull class]]){ //Creating a transient prop for holding the item ID's (These items may not have been created yet!)
            
            NSMutableString * compArrayString = [NSMutableString string];
            
            for (NSString * comp in compArray) {
                [compArrayString appendFormat:@"%@,",comp];
            }
            
            [compArrayString deleteCharactersInRange:NSMakeRange(compArrayString.length-1,1)];
            i.comp_string = compArrayString;
        }
    }
    
    return i;
}

@end
