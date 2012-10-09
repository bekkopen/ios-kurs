//
//  HeiPaDereViewController.m
//  Kurs
//
//  Created by Hans Magnus Inderberg on 10/9/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "HeiPaDereViewController.h"

@interface HeiPaDereViewController ()

@end

@implementation HeiPaDereViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouch:(id)sender
{
    self.label.text = self.textField.text;
}


@end
