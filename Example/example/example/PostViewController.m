//
//  PostViewController.m
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "PostViewController.h"
#import <library/library.h>

@interface PostViewController ()

@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)postFrom:(NSString *)from withMessage:(NSString *)message
{
    NSString *postString = [NSString stringWithFormat:@"http://ioskurs.herokuapp.com/post?from=%@&message=%@", from, message];
    
    [Downloader startDownloadWithRequest:[Downloader createPostRequestForUrl:[NSURL URLWithString:postString]] successHandler:^(NSData *data)
     {
     } failedHandler:^(NSError *error)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feilet" message:@"Kunne ikke sende bedskjed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
