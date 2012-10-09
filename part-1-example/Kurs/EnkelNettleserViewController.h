//
//  pickerViewController.h
//  Kurs
//
//  Created by Hans Magnus Inderberg on 10/9/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnkelNettleserViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
