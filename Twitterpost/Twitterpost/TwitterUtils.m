//
//  TwitterUtils.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 5/29/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "TwitterUtils.h"

@implementation TwitterUtils
@synthesize accountStore;
@synthesize account;


- (void) isGrantedUseOfAccount:(id)delegate onSuccess:(SEL)successCallback onError:(SEL)errorCallback
{
    if(self.accountStore == nil){
        [self setAccountStore:[[ACAccountStore alloc] init]];
    }

	// Create an account type that ensures Twitter accounts are retrieved.
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted)
        {
            NSArray *accountsArray = [self.accountStore accountsWithAccountType:accountType];
            
			if ([accountsArray count] > 0) {
                [self setAccount:[accountsArray objectAtIndex:0]];
                
                [delegate performSelectorOnMainThread:successCallback withObject:nil waitUntilDone:YES];
            }
        } else {
            [delegate performSelector:errorCallback];
        }
        
    }];
}

-(void) tweet:(NSString *) theTweet
{
    NSURL *updateUrl = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:theTweet, @"status", nil];
    
    TWRequest *request = [[TWRequest alloc] initWithURL:updateUrl parameters:params requestMethod:TWRequestMethodPOST];
        
    request.account = self.account;
    NSLog(@"%@", request.account);
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:NULL];
        
        NSLog(@"%@", dict);
    }];
}

@synthesize delegate;
@synthesize successCallback;
@synthesize errorCallback;

@end
