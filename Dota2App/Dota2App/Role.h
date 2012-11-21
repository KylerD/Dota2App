//
//  Role.h
//  Dota2App
//
//  Created by Kyle Davidson on 21/11/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Role : NSManagedObject

@property (nonatomic, retain) NSString * roleName;
@property (nonatomic, retain) NSString * roleImage;
@property (nonatomic, retain) NSSet *heros;
@end

@interface Role (CoreDataGeneratedAccessors)

- (void)addHerosObject:(Hero *)value;
- (void)removeHerosObject:(Hero *)value;
- (void)addHeros:(NSSet *)values;
- (void)removeHeros:(NSSet *)values;

@end
