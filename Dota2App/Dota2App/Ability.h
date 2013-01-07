//
//  Ability.h
//  Dota2App
//
//  Created by Kyle Davidson on 07/01/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Ability : NSManagedObject

@property (nonatomic, retain) NSString * cd;
@property (nonatomic, retain) NSString * damage;
@property (nonatomic, retain) NSData * dynamic;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * isAura;
@property (nonatomic, retain) NSNumber * isAutoCast;
@property (nonatomic, retain) NSNumber * isPassive;
@property (nonatomic, retain) NSNumber * isToggle;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSString * mc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * radius;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSString * imgUrl;
@property (nonatomic, retain) Hero *hero;

@end
