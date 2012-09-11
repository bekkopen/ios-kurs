//
//  PAccountUtil.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 9/10/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "PAccountProtocol.h"
#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@interface PAccountUtil : NSObject{
    @private
    id<PAccountProtocol> delegate;
}

- (id) initWithDelegate: (id<PAccountProtocol>) delegate;
- (void) grantAccessToAccount;

@property(nonatomic, strong) ACAccountStore *accountStore;
@property(nonatomic, strong) ACAccount *account;

@end
