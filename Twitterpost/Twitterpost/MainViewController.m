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

@implementation MainViewController 

@synthesize au;
@synthesize tu;
@synthesize tweetListController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TwitterDelegate

- (void) loadStarted
{
    [activity startAnimating];
}

- (void) loadFinished
{
    [activity stopAnimating];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setTu: [[TwitterUtils alloc] initWithDelegate:self]];
    [self setAu: [[AccountUtil alloc] init]];
    
    [self.au isGrantedAccess:^(ACAccount *account){
        [self.tu setAccount:self.au.account];
        NSString *title = [[NSString alloc] initWithFormat:@"Twitter: %@", au.account.username];
        
        [self setTitle:title];
        [activity stopAnimating];
        [tweetBtn setEnabled:YES];
    } errorHandler:^(){
        NSLog(@"Feilet");
    }];
    
    activity.hidesWhenStopped = true;
    [activity startAnimating];
    
    [tweetBtn setEnabled:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) onError{
    NSLog(@"Du må godkjenne bruk av konto");
}

- (void) tweetText:(id)sender{    
    [self.tu tweet:[tweetTextView text]];
    [tweetTextView resignFirstResponder];
}

- (void) showLatest:(id) sender{
    if(!tweetListController){
        tweetListController = [[ShowListController alloc] init];
        [tweetListController setTu:[self tu]];
    }
    
    [[self navigationController] pushViewController:tweetListController animated:YES];
}

@end
