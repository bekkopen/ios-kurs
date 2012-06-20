//
//  ViewController.m
//  Twitterpost
//
//  Created by Eivind Bergstøl on 5/9/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "MainViewController.h"
#import "TwitterUtils.h"
#import "ShowListController.h"

@implementation MainViewController 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    TwitterUtils *tu = [[TwitterUtils alloc] init];
    
    [tu isGrantedUseOfAccount:self onSuccess:@selector(onSuccess:) onError:@selector(onError)];
    
    activity.hidesWhenStopped = true;
    [activity startAnimating];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) onSuccess:(ACAccount *) account{
    NSLog(@"Du kan nå bruke twitterkontoen");
    [username setText:account.username];
    [activity stopAnimating];
}

- (void) onError{
    NSLog(@"Du må godkjenne bruk av konto");
}

- (void) showLatest:(id) sender{
    NSLog(@"Klikket!!");
    ShowListController *slc = [[ShowListController alloc] init];
    
    [[self navigationController] pushViewController:slc animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear    :(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
