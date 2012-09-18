//
//  ViewController.m
//  example
//
//  Created by Hans Magnus Inderberg on 9/17/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "ViewController.h"
#import <library/library.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Downloader startDownloadWithRequest:[Downloader createGetRequestForUrl:[NSURL URLWithString:@"http://stormy-reef-4228.herokuapp.com/post?from=sdssdsd&message=Test"]] successHandler:^(NSData *data)
     {
         NSError *error = nil;
         NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         NSLog(@"%@", jsonObjects);
     } failedHandler:^(NSError *error)
     {
         
     }];
    
    [Downloader startDownloadWithRequest:[Downloader createGetRequestForUrl:[NSURL URLWithString:@"http://stormy-reef-4228.herokuapp.com/json"]] successHandler:^(NSData *data)
    {
        NSError *error = nil;
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         NSLog(@"%@", jsonObjects);
    } failedHandler:^(NSError *error)
    {
         
    }];
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
