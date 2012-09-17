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

@interface MainViewController : UIViewController
{}

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITextField *tweetTextView;
@property (weak, nonatomic) IBOutlet UIButton *tweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *tweetListBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)showLatest:(id)sender;
- (IBAction)tweetText:(id)sender;

@end
