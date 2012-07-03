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

@interface TwitterUtils : NSObject{    
    id delegate;
    SEL successCallback;
    SEL errorCallback;
}

@property(nonatomic) SEL successCallback;
@property(nonatomic) SEL errorCallback;
@property(nonatomic, retain) id delegate;
@property(nonatomic, retain) ACAccountStore *accountStore;
@property(nonatomic, retain) ACAccount *account;

- (void) isGrantedUseOfAccount:(id)delegate onSuccess:(SEL) successCallback onError:(SEL) errorCallback;
- (void) tweet:(NSString *) theTweet;

@end
