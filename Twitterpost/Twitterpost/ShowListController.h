//
//  ShowListController.h
//  Twitterpost
//
//  Created by Eivind Bergstøl on 6/19/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowListController : UITableViewController{
    IBOutlet UITableView *tweetTableView;
}

@property (nonatomic, retain) NSMutableArray *tweets;

@end
