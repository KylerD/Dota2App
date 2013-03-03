//
//  Nickname.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Nickname : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * nickname_id;
@property (nonatomic, retain) NSDecimalNumber * createddate;
@property (nonatomic, retain) NSDecimalNumber * lastmoddate;
@property (nonatomic, retain) NSSet *heroes;
@end

@interface Nickname (CoreDataGeneratedAccessors)

- (void)addHeroesObject:(Hero *)value;
- (void)removeHeroesObject:(Hero *)value;
- (void)addHeroes:(NSSet *)values;
- (void)removeHeroes:(NSSet *)values;

@end
