//
//  Message.h
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *date;
@end
