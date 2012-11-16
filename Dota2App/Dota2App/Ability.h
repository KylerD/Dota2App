//
//  Ability.h
//  Dota2App
//
//  Created by Kyle Davidson on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ability : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * ability;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * affects;
@property (nonatomic, retain) NSString * damage;
@property (nonatomic, retain) NSString * radius;
@property (nonatomic, retain) NSString * imagePath;

@end
