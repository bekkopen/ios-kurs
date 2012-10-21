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
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(doRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView addSubview:refreshControl];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self doRefresh];
}

- (void)doRefresh
{
    
    [KURLConnection startWithRequest:
     [KURLConnection createGetRequestForUrl:[NSURL URLWithString:@"http://localhost:3000/message"]]
                      successHandler:^(NSData *data)
     {
         MessageParser *messageParser = [[MessageParser alloc] init];
         
         NSError *error = nil;
         self.messages = [messageParser createMessagesFromJSON:data error:&error];
         [self.refreshControl endRefreshing];
         
         if (error != nil)
         {
             [self showAlert];
             return;
         }
                    
         [self.tableView reloadData];
     } failedHandler:^(NSError *error)
     {
         [self.refreshControl endRefreshing];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - UITableViewDataSource

#define PADDING 18.0f
- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [(self.messages)[indexPath.row] message];
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
    UITableViewCell *cell = nil;
    
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
    {
         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];   
    }
    
   
    
    Message *message = (self.messages)[indexPath.row];
    
    UILabel *fromLabel = (UILabel *)[cell viewWithTag:100];
	fromLabel.text = message.from;
	
    UITextView *messageTextView = (UITextView *)[cell viewWithTag:101];
    messageTextView.contentInset = UIEdgeInsetsMake(-8,-8,0,0);
    messageTextView.text = message.message;
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:102];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [df stringFromDate:message.date];
    
    CGRect frame;
    frame = messageTextView.frame;
    frame.size.height = [messageTextView contentSize].height;
    messageTextView.frame = frame;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
