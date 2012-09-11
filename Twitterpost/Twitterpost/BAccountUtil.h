//
//  AccountUtil.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 9/10/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface AccountUtil : UITableViewController{
    IBOutlet UITableView *accountSelectorTableView;
}

typedef void(^SuccessHandler)(ACAccount *);
typedef void(^ErrorHandler)();

- (void) isGrantedAccess:(SuccessHandler)successHandler errorHandler:(ErrorHandler)errorHandler;

@property(nonatomic, strong) ACAccountStore *accountStore;
@property(nonatomic, strong) ACAccount *account;

@end
