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

@synthesize tu;
@synthesize tweetListController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setTu: [[TwitterUtils alloc] init]];
    
    [tu isGrantedUseOfAccount:self onSuccess:@selector(onSuccess) onError:@selector(onError)];
    
    activity.hidesWhenStopped = true;
    [activity startAnimating];
    
    [tweetBtn setEnabled:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) onSuccess{
    [username setText:tu.account.username];
    [activity stopAnimating];
    [tweetBtn setEnabled:YES];
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
