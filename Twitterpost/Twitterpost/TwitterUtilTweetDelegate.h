//
//  TwitterUtilTweetDelegate.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 9/4/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TwitterUtilTweetDelegate <NSObject>

@required
- (void) loadStarted;

@required
- (void) loadFinished;

@end
