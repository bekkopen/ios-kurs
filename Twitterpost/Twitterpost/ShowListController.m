//
//  ShowListController.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 6/19/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "ShowListController.h"

@implementation ShowListController

@synthesize tweets;

- (id) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    [self setTweets:[[NSMutableArray alloc] init]];
    
    [[self tweets] addObject:@"Min testcelle"];
    NSLog(@"%i", [tweets count]);
    return self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [tweets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    NSString *s = [tweets objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:s];
    
    return cell;
}

@end
