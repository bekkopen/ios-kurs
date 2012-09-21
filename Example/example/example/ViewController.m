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
#import "Message.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *messages;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
         
         [self.tableView reloadData];
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
    [self setTableView:nil];
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


#pragma mark - Table view data source

#define PADDING 15.0f
- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [[self.messages objectAtIndex:indexPath.row] message];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.tableView.frame.size.width - PADDING * 3, 1000.0f)];
    
    return textSize.height + PADDING * 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Message *message = [self.messages objectAtIndex:indexPath.row];
    
    UILabel *fromLabel = (UILabel *)[cell viewWithTag:100];
	fromLabel.text = message.from;
	
    UITextView *messageTextView = (UITextView *)[cell viewWithTag:101];
    messageTextView.text = message.message;
    
    CGRect frame;
    frame = messageTextView.frame;
    frame.size.height = [messageTextView contentSize].height;
    messageTextView.frame = frame;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
