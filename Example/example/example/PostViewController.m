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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)postFrom:(NSString *)from withMessage:(NSString *)message
{
    NSString *postString = [NSString stringWithFormat:@"http://ioskurs.herokuapp.com/post?from=%@&message=%@", from, message];
    
    [Downloader startDownloadWithRequest:[Downloader createPostRequestForUrl:[NSURL URLWithString:postString]] successHandler:^(NSData *data)
     {
         [self cancelTouch:nil];
     } failedHandler:^(NSError *error)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feilet" message:@"Kunne ikke sende bedskjed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelTouch:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendTouch:(id)sender
{
    [self postFrom:@"Some" withMessage:self.textView.text];
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
