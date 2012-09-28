//
//  PostViewController.h
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController
- (IBAction)cancelTouch:(id)sender;
- (IBAction)sendTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIView *navigationTitleView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
