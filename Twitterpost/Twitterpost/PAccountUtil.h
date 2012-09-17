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

@interface PAccountUtil : NSObject
{}

- (id)initWithDelegate:(id<PAccountProtocol>)delegate;
- (void)grantAccessToAccount;

@end
