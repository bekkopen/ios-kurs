//
//  ShowListController.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 6/19/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "ShowListController.h"

@interface ShowListController ()
@property (nonatomic, retain) TwitterUtils *twitterUtils;
@property (nonatomic, retain) NSArray *tweets;

- (void) gotTweets:(NSArray *) tweetDict;
- (void) error;
@end

@implementation ShowListController

@synthesize tweets;
@synthesize twitterUtils;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTweets:[[NSArray alloc] init]];
    [self setTwitterUtils:[[TwitterUtils alloc] init]];
}


- (void)viewDidAppear:(BOOL)animated{
    [twitterUtils getTweets:self onSuccess:@selector(gotTweets:) onError:@selector(error)];
}

- (void) gotTweets:(NSArray *) tweetDict{
    self.tweets = tweetDict;
    NSLog(@"%@", self.tweets);
    [self.tableView reloadData];
}

- (void) error{
    NSLog(@"GOT ERROR");
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%i", [tweets count]);

    return [tweets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";  
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];  
    if (cell == nil) {  
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }  
    
    // Configure the cell...  
    NSDictionary *aTweet = [tweets objectAtIndex:indexPath.row];
    cell.textLabel.text = [aTweet objectForKey:@"text"];  
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:12];  
    cell.textLabel.numberOfLines = 4;  
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;  
    
    NSDictionary *user = [aTweet objectForKey:@"user"];
    
    cell.detailTextLabel.text = [user objectForKey:@"name"];
    
    NSURL *url = [NSURL URLWithString:[user objectForKey:@"profile_image_url"]];  
    NSData *data = [NSData dataWithContentsOfURL:url];  
    cell.imageView.image = [UIImage imageWithData:data];  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  
    return cell;  
}

@end
