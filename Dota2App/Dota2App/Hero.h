//
//  Hero.h
//  Dota2App
//
//  Created by Jamie O'Hara on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hero : NSManagedObject

@property (nonatomic, retain) NSNumber * radiant;
@property (nonatomic, retain) NSNumber * dire;
@property (nonatomic, retain) NSNumber * strength;
@property (nonatomic, retain) NSNumber * intelligence;
@property (nonatomic, retain) NSNumber * agility;

@end
