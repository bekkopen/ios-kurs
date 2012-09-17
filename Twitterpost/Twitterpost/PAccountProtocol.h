//
//  PAccountProtocol.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 9/10/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@protocol PAccountProtocol <NSObject>

@required
- (void)didGetAccount:(ACAccount *)account;
@required
- (void)didFailWithErros:(NSString *)error;

@end
