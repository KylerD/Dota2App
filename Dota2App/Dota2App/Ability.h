//
//  Ability.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Ability : NSManagedObject

@property (nonatomic, retain) NSString * ability_id;
@property (nonatomic, retain) NSString * cd;
@property (nonatomic, retain) NSString * damage;
@property (nonatomic, retain) NSString * dynamic;
@property (nonatomic, retain) NSString * image_path;
@property (nonatomic, retain) NSString * img_url;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * is_aura;
@property (nonatomic, retain) NSNumber * is_auto_cast;
@property (nonatomic, retain) NSNumber * is_channeled;
@property (nonatomic, retain) NSNumber * is_passive;
@property (nonatomic, retain) NSNumber * is_toggle;
@property (nonatomic, retain) NSString * lore;
@property (nonatomic, retain) NSString * mc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * radius;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * unique_ability_id;
@property (nonatomic, retain) NSString * video_url;
@property (nonatomic, retain) NSDecimalNumber * createddate;
@property (nonatomic, retain) NSDecimalNumber * lastmoddate;
@property (nonatomic, retain) Hero *hero;

@end
