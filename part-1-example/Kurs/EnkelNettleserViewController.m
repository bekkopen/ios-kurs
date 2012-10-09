//
//  pickerViewController.m
//  Kurs
//
//  Created by Hans Magnus Inderberg on 10/9/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "EnkelNettleserViewController.h"

@interface EnkelNettleserViewController ()
@property(nonatomic, strong) NSArray *array;
@end

@implementation EnkelNettleserViewController

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
	self.array = @[@"http://vg.no", @"http://dn.no", @"http://e24.no"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.array.count;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *urlString = [self.array objectAtIndex:row];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:urlRequest];
}


@end
