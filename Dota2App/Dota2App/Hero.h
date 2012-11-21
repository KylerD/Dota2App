//
//  Hero.h
//  Dota2App
//
//  Created by Kyle Davidson on 21/11/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ability, Role;

@interface Hero : NSManagedObject

@property (nonatomic, retain) NSNumber * agilPoints;
@property (nonatomic, retain) NSString * primaryAttribute;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * detailImage;
@property (nonatomic, retain) NSString * faction;
@property (nonatomic, retain) NSString * iconImage;
@property (nonatomic, retain) NSNumber * intelPoints;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSNumber * strPoints;
@property (nonatomic, retain) NSDate * lastModified;
@property (nonatomic, retain) NSNumber * strGain;
@property (nonatomic, retain) NSNumber * agilGain;
@property (nonatomic, retain) NSNumber * intelGain;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSNumber * armour;
@property (nonatomic, retain) NSNumber * missileSpeed;
@property (nonatomic, retain) NSNumber * castPoints;
@property (nonatomic, retain) NSNumber * attackPoints;
@property (nonatomic, retain) NSNumber * ms;
@property (nonatomic, retain) NSNumber * attackBackswing;
@property (nonatomic, retain) NSNumber * castBackswing;
@property (nonatomic, retain) NSNumber * dmgMin;
@property (nonatomic, retain) NSNumber * dmgMax;
@property (nonatomic, retain) NSString * quote;
@property (nonatomic, retain) NSNumber * turnRate;
@property (nonatomic, retain) NSNumber * sightDay;
@property (nonatomic, retain) NSNumber * sightNight;
@property (nonatomic, retain) NSNumber * attackRange;
@property (nonatomic, retain) NSNumber * mana;
@property (nonatomic, retain) NSNumber * hp;
@property (nonatomic, retain) NSString * heroId;
@property (nonatomic, retain) NSSet *abilities;
@property (nonatomic, retain) NSSet *roles;
@end

@interface Hero (CoreDataGeneratedAccessors)

- (void)addAbilitiesObject:(Ability *)value;
- (void)removeAbilitiesObject:(Ability *)value;
- (void)addAbilities:(NSSet *)values;
- (void)removeAbilities:(NSSet *)values;

- (void)addRolesObject:(Role *)value;
- (void)removeRolesObject:(Role *)value;
- (void)addRoles:(NSSet *)values;
- (void)removeRoles:(NSSet *)values;

@end
