//
//  Ability.h
//  Dota2App
//
//  Created by Kyle Davidson on 21/11/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Ability : NSManagedObject

@property (nonatomic, retain) NSString * ability;
@property (nonatomic, retain) NSString * affects;
@property (nonatomic, retain) NSString * damage;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * radius;
@property (nonatomic, retain) NSString * abilityId;
@property (nonatomic, retain) Hero *hero;

@end
