//
//  ViewController.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 5/9/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "MainViewController.h"
#import "TwitterUtils.h"
#import "ShowListController.h"

@interface MainViewController ()
@property(nonatomic, strong) TwitterUtils *twitterUtils;
@property(nonatomic, strong) BAccountUtil *accountUtils;

- (void)onSuccess;
- (void)onError;
@end

@implementation MainViewController 

@synthesize accountUtils;
@synthesize twitterUtils;

#pragma mark - TwitterDelegate

- (void) loadStarted
{
    [self.activity startAnimating];
}

- (void) loadFinished
{
    [self.activity stopAnimating];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTwitterUtils:[[TwitterUtils alloc] initWithDelegate:self]];
    [self setAccountUtils:[[BAccountUtil alloc] init]];
    
    [self.accountUtils isGrantedAccess:^(ACAccount *account)
    {
        [self.twitterUtils setAccount:self.accountUtils.account];
        
        NSString *title = [[NSString alloc] initWithFormat:@"Twitter: %@", accountUtils.account.username];
        [self setTitle:title];
        
        [self.activity stopAnimating];
        [self.tweetBtn setEnabled:YES];
    } errorHandler:^()
    {
        [self.activity stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Feilet" message:@"Kunne ikke finne twitter konto" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
    self.activity.hidesWhenStopped = true;
    [self.activity startAnimating];
    [self.tweetBtn setEnabled:NO];
}

- (void)onError
{
    NSLog(@"Du må godkjenne bruk av konto");
}

- (void)tweetText:(id)sender
{
    [self.twitterUtils tweet:[self.tweetTextView text]];
    [self.tweetTextView resignFirstResponder];
}

- (void) showLatest:(id)sender
{
    ShowListController *tweetListController = [[ShowListController alloc] initWithNibName:@"ShowListController" bundle:[NSBundle mainBundle]];
    
    [[self navigationController] pushViewController:tweetListController animated:YES];
}

@end
