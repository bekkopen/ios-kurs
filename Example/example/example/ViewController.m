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
    
    [Downloader startDownloadWithUrl:[NSURL URLWithString:@"http://vg.no"] successHandler:^(NSData *data)
    {
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
