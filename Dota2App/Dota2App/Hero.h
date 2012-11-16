//
//  Hero.h
//  Dota2App
//
//  Created by Kyle Davidson on 16/11/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hero : NSManagedObject

@property (nonatomic, retain) NSString * attribute;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * detailImage;
@property (nonatomic, retain) NSString * faction;
@property (nonatomic, retain) NSString * iconImage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * strengthPoints;
@property (nonatomic, retain) NSString * agilityPoints;
@property (nonatomic, retain) NSString * intelligencePoints;
@property (nonatomic, retain) NSString * role;

@end
