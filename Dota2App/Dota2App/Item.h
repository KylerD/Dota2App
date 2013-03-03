//
//  Item.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * attrib_string;
@property (nonatomic, retain) NSString * comp_string;
@property (nonatomic, retain) NSNumber * cool_down;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * img_path;
@property (nonatomic, retain) NSString * img_url;
@property (nonatomic, retain) NSString * item_id;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSNumber * mana_cost;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * unique_item_id;
@property (nonatomic, retain) NSDecimalNumber * createddate;
@property (nonatomic, retain) NSDecimalNumber * lastmoddate;
@property (nonatomic, retain) NSSet *components;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addComponentsObject:(Item *)value;
- (void)removeComponentsObject:(Item *)value;
- (void)addComponents:(NSSet *)values;
- (void)removeComponents:(NSSet *)values;

@end
