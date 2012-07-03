//
//  ViewController.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 5/9/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <Accounts/ACAccountType.h>

@interface MainViewController : UIViewController{
    IBOutlet UILabel *username;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIButton *tweetBtn;
}

-(void) onSuccess:(ACAccount *) account;
-(void) onError;
-(IBAction)showLatest:(id)sender;


@end
