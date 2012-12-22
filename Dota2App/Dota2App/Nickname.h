//
//  Nickname.h
//  Dota2App
//
//  Created by Luke McNeice on 22/12/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Nickname : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *heroes;
@end

@interface Nickname (CoreDataGeneratedAccessors)

- (void)addHeroesObject:(Hero *)value;
- (void)removeHeroesObject:(Hero *)value;
- (void)addHeroes:(NSSet *)values;
- (void)removeHeroes:(NSSet *)values;

@end
