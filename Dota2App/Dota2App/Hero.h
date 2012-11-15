//
//  Hero.h
//  Dota2App
//
//  Created by Kyle Davidson on 15/11/2012.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hero : NSManagedObject

@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * detailImage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spec;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * iconImage;

@end
