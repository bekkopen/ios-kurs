//
//  TwitterUtils.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 5/29/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "TwitterUtils.h"

@implementation TwitterUtils

- (void) isGrantedUseOfAccount:(id)delegate onSuccess:(SEL)successCallback onError:(SEL)errorCallback
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	
	// Create an account type that ensures Twitter accounts are retrieved.
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted)
        {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            
			if ([accountsArray count] > 0) {
				ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                
                //[delegate performSelector:successCallback withObject:twitterAccount];
                [delegate performSelectorOnMainThread:successCallback withObject:twitterAccount waitUntilDone:YES];
            }
        } else {
            [delegate performSelector:errorCallback];
        }
        
    }];
}

@synthesize delegate;
@synthesize successCallback;
@synthesize errorCallback;

@end
