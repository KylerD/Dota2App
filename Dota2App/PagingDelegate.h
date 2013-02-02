//
//  PagingDelegate
//  Dota2App
//
//  Created by Luke McNeice on 20/01/2013.
//
//

#import <Foundation/Foundation.h>

@protocol PagingDelegate <NSObject>
- (void)dismissModalFromParent;
- (void)stopAutoPaging;
@end
