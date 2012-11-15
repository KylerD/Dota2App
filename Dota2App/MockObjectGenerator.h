//
//  MockObjectGenerator.h
//  Dota2App
//
//  Created by Jamie O'Hara on 10/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"

@interface MockObjectGenerator : NSObject {
    // Used to Generate some random hero names/bios/images
    NSArray *heroNames;
    NSArray *heroBiographies;
    NSArray *heroImages;
    NSArray *heroIcons;
    //The managed object context
    NSManagedObjectContext *context;
}


- (void)generateRandomHeros;

@end
