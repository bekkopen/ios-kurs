//
//  PostViewController.m
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "PostViewController.h"
#import <library/library.h>
#import "Message.h"
#import "MessageParser.h"

@interface PostViewController ()
@property (nonatomic, strong) NSString *username;
@end

@implementation PostViewController

static NSString *usernameKey = @"username";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *savedUsername = [[NSUserDefaults standardUserDefaults] objectForKey:usernameKey];
    
    if (savedUsername != nil)
    {
        self.username = savedUsername;
    }
    else
    {
        self.username = @"unknown";
    }
    
    self.usernameLabel.text = self.username;

    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.navigationTitleView addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIAlertView *inputAlert = [[UIAlertView alloc] initWithTitle:@"Brukernavn" message:@"Skriv inn brukernavn" delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:@"OK", nil];
    inputAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *name = [alertView textFieldAtIndex:0].text;
        self.username = name;
        self.usernameLabel.text = self.username;
        [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:usernameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)postFrom:(NSString *)from withMessage:(NSString *)message
{
    
    NSURL *postUrl = [NSURL URLWithString:@"http://localhost:3000/message"];
    Message *messageObject = [[Message alloc] init];
    messageObject.from = from;
    messageObject.message = message;
    messageObject.date = [NSDate date];
    
    NSError *error = nil;
    MessageParser *messageParser = [[MessageParser alloc] init];
    NSData *jsonData = [messageParser createJSONFromMessage:messageObject error:&error];
    
    if (error != nil)
    {
        [self showAlert];
        return;
    }

    [KURLConnection startWithRequest:[KURLConnection createPostRequestForUrl:postUrl withJSONData:jsonData] successHandler:^(NSData *data)
     {
         [self cancelTouch:nil];
     } failedHandler:^(NSError *error)
     {
         [self showAlert];
     }];
}

- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feilet" message:@"Kunne ikke sende bedskjed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
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
    [self postFrom:self.username withMessage:self.textView.text];
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [self setUsernameLabel:nil];
    [self setNavigationTitleView:nil];
    [super viewDidUnload];
}
@end
