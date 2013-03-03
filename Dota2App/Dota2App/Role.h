//
//  Role.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Role : NSManagedObject

@property (nonatomic, retain) NSString * role_id;
@property (nonatomic, retain) NSString * role_image;
@property (nonatomic, retain) NSString * role_name;
@property (nonatomic, retain) NSDecimalNumber * lastmoddate;
@property (nonatomic, retain) NSDecimalNumber * createddate;
@property (nonatomic, retain) NSSet *heros;
@end

@interface Role (CoreDataGeneratedAccessors)

- (void)addHerosObject:(Hero *)value;
- (void)removeHerosObject:(Hero *)value;
- (void)addHeros:(NSSet *)values;
- (void)removeHeros:(NSSet *)values;

@end
