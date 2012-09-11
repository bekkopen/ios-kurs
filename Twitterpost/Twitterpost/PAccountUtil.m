//
//  PAccountUtil.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 9/10/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "PAccountUtil.h"
#import <Accounts/Accounts.h>


@implementation PAccountUtil

@synthesize account;
@synthesize accountStore;

- (id) initWithDelegate:(id<PAccountProtocol>)delegateObj{
    self = [super init];
    
    if(self){
        delegate = delegateObj;
        self.accountStore = [[ACAccountStore alloc] init];
    }
    
    return self;
}

- (void) grantAccessToAccount{
    if(self.account){
        [(id)delegate performSelectorOnMainThread:@selector(didGetAccount:) withObject:self.account waitUntilDone:YES];
    }
    
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [self.accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted)
        {
            NSArray *accountsArray = [self.accountStore accountsWithAccountType:accountType];
			if ([accountsArray count] > 0) {
                self.account = [accountsArray objectAtIndex:0];
                NSLog(@"Det var %i konto(er) registrert. Valgte %@.", accountsArray.count, self.account.username);
                
                [(id)delegate performSelectorOnMainThread:@selector(didGetAccount:) withObject:self.account waitUntilDone:YES];
            }
        } else {
            [(id)delegate performSelectorOnMainThread:@selector(didFailWithErros) withObject:@"Det gikk til helvete..." waitUntilDone:YES];
        }
    }];
}

@end
