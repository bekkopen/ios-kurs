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
#import "BAccountUtil.h"
#import "TwitterUtils.h"
#import "TwitterUtilTweetDelegate.h"
#import "ShowListController.h"
#import "PAccountProtocol.h"

@interface MainViewController : UIViewController <TwitterUtilTweetDelegate, PAccountProtocol> {
    IBOutlet UILabel *username;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIButton *tweetBtn;
    IBOutlet UITextField *tweetTextView;
    IBOutlet UIButton *tweetListBtn;
}

@property(nonatomic, strong) TwitterUtils *tu;
@property(nonatomic, strong) AccountUtil *au;
@property(nonatomic, strong) ShowListController *tweetListController;

-(void) onSuccess;
-(void) onError;
-(IBAction)showLatest:(id)sender;
-(IBAction)tweetText:(id)sender;


@end
