//
//  Ability.h
//  Dota2App
//
//  Created by Kyle Davidson on 03/12/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Ability : NSManagedObject

@property (nonatomic, retain) NSString * ability;
@property (nonatomic, retain) NSString * abilityId;
@property (nonatomic, retain) NSString * affects;
@property (nonatomic, retain) NSString * damage;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * radius;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSString * imgUrl;
@property (nonatomic, retain) Hero *hero;

@end
