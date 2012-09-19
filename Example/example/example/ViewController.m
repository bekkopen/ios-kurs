//
//  ViewController.m
//  example
//
//  Created by Hans Magnus Inderberg on 9/17/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "ViewController.h"
#import <library/library.h>
#import "MessageParser.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *messages;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [Downloader startDownloadWithRequest:[Downloader createGetRequestForUrl:[NSURL URLWithString:@"http://ioskurs.herokuapp.com/json"]] successHandler:^(NSData *data)
    {
        MessageParser *messageParser = [[MessageParser alloc] init];
        
        NSError *error = nil;
        self.messages = [messageParser createMessagesFromJSON:data error:&error];
        
        if (error != nil)
        {
            [self showAlert];
            return;
        }        
    } failedHandler:^(NSError *error)
    {
        [self showAlert];
    }];
}

- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feil oppsto" message:@"Kunne ikke hente meldinger" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
