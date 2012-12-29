//
//  YouTubeView.h
//  blogScratchApp
//
//  Created by John on 5/18/10.
//  Copyright 2010 iPhoneDeveloperTips.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouTubeView : UIWebView 
{
}

- (YouTubeView *)initWithStringAsURL:(NSString *)urlString frame:(CGRect)frame;

@end
