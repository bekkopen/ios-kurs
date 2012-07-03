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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    TwitterUtils *tu = [[TwitterUtils alloc] init];
    
    [tu isGrantedUseOfAccount:self onSuccess:@selector(onSuccess:) onError:@selector(onError)];
    
    activity.hidesWhenStopped = true;
    [activity startAnimating];
    
    [tweetBtn setEnabled:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) onSuccess:(ACAccount *) account{
    [username setText:account.username];
    [activity stopAnimating];
    [tweetBtn setEnabled:YES];
}

- (void) onError{
    NSLog(@"Du må godkjenne bruk av konto");
}

- (void) showLatest:(id) sender{
    ShowListController *slc = [[ShowListController alloc] init];
    
    [[self navigationController] pushViewController:slc animated:YES];
}

@end
