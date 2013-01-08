//
//  Item.h
//  Dota2App
//
//  Created by Kyle Davidson on 08/01/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * attribString;
@property (nonatomic, retain) NSString * compString;
@property (nonatomic, retain) NSNumber * coolDown;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * itemID;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSNumber * manaCost;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * imgPath;
@property (nonatomic, retain) NSString * imgUrl;
@property (nonatomic, retain) NSSet *components;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addComponentsObject:(Item *)value;
- (void)removeComponentsObject:(Item *)value;
- (void)addComponents:(NSSet *)values;
- (void)removeComponents:(NSSet *)values;

@end
