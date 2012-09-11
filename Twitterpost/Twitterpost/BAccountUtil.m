//
//  AccountUtil.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 9/10/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "BAccountUtil.h"

@implementation AccountUtil

@synthesize accountStore;
@synthesize account;

-(id) init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        self.accountStore = [[ACAccountStore alloc] init];
    }
    
    return self;
}

-(void) isGrantedAccess:(SuccessHandler)successHandler errorHandler:(ErrorHandler)errorHandler{
    if(self.account){
        successHandler(self.account);
        return;
    }
    
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted)
        {
            NSArray *accountsArray = [self.accountStore accountsWithAccountType:accountType];
			if ([accountsArray count] > 0) {
                self.account = [accountsArray objectAtIndex:0];
                NSLog(@"Det var %i konto(er) registrert. Valgte %@.", accountsArray.count, self.account.username);
                dispatch_async(dispatch_get_main_queue(), ^{
                    successHandler(self.account);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                errorHandler();
            });
        }
    }];
}

@end
