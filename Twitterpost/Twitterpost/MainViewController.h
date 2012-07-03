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
#import "TwitterUtils.h"

@interface MainViewController : UIViewController{
    IBOutlet UILabel *username;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIButton *tweetBtn;
    IBOutlet UITextField *tweetTextView;
    IBOutlet UIButton *tweetListBtn;
}

@property(nonatomic, retain) TwitterUtils *tu;

-(void) onSuccess;
-(void) onError;
-(IBAction)showLatest:(id)sender;
-(IBAction)tweetText:(id)sender;


@end
