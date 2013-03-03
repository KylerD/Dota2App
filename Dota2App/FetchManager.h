//
//  PrefetchManager.h
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import <Foundation/Foundation.h>

@interface FetchManager : NSObject
@property dispatch_queue_t fetchQueue;
-(void)fetchAll;

@end
