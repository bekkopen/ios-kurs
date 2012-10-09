//
//  HeiPaDereViewController.h
//  Kurs
//
//  Created by Hans Magnus Inderberg on 10/9/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeiPaDereViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)buttonTouch:(id)sender;
@end
