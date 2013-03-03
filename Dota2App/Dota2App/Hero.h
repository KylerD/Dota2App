//
//  Hero.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ability, Nickname, Role;

@interface Hero : NSManagedObject

@property (nonatomic, retain) NSNumber * agil_gain;
@property (nonatomic, retain) NSNumber * agil_points;
@property (nonatomic, retain) NSNumber * armour;
@property (nonatomic, retain) NSNumber * attack_range;
@property (nonatomic, retain) NSString * attack_type;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * damage;
@property (nonatomic, retain) NSString * detail_img_url;
@property (nonatomic, retain) NSString * faction;
@property (nonatomic, retain) NSString * hero_id;
@property (nonatomic, retain) NSNumber * hp;
@property (nonatomic, retain) NSString * icon_image;
@property (nonatomic, retain) NSNumber * intel_gain;
@property (nonatomic, retain) NSNumber * intel_points;
@property (nonatomic, retain) NSDecimalNumber * lastmoddate;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSNumber * mana;
@property (nonatomic, retain) NSNumber * missile_speed;
@property (nonatomic, retain) NSNumber * ms;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * primary_attribute;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * sight;
@property (nonatomic, retain) NSNumber * str_gain;
@property (nonatomic, retain) NSNumber * str_points;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDecimalNumber * createddate;
@property (nonatomic, retain) NSSet *abilities;
@property (nonatomic, retain) NSSet *nicknames;
@property (nonatomic, retain) NSSet *roles;
@end

@interface Hero (CoreDataGeneratedAccessors)

- (void)addAbilitiesObject:(Ability *)value;
- (void)removeAbilitiesObject:(Ability *)value;
- (void)addAbilities:(NSSet *)values;
- (void)removeAbilities:(NSSet *)values;

- (void)addNicknamesObject:(Nickname *)value;
- (void)removeNicknamesObject:(Nickname *)value;
- (void)addNicknames:(NSSet *)values;
- (void)removeNicknames:(NSSet *)values;

- (void)addRolesObject:(Role *)value;
- (void)removeRolesObject:(Role *)value;
- (void)addRoles:(NSSet *)values;
- (void)removeRoles:(NSSet *)values;

@end
