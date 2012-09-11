//
//  TwitterUtils.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 5/29/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "TwitterUtilTweetDelegate.h"

@interface TwitterUtils : NSObject{    
    id delegate;
    SEL successCallback;
    SEL errorCallback;
}

@property(nonatomic) SEL successCallback;
@property(nonatomic) SEL errorCallback;
@property(nonatomic, strong) ACAccountStore *accountStore;
@property(nonatomic, strong) ACAccount *account;
@property(nonatomic, weak) id<TwitterUtilTweetDelegate> loadDelegate;

- (id) initWithDelegate:(id <TwitterUtilTweetDelegate>) loadDelegateObject;
- (void) tweet:(NSString *) theTweet;
- (void) getTweets:(id)delegate onSuccess:(SEL) successCallback onError:(SEL) errorCallback;

@end
