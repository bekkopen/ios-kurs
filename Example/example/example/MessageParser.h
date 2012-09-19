//
//  MessageParser.h
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageParser : NSObject

- (NSArray *)createMessagesFromJSON:(NSData *)messagesJSON error:(NSError **)error;

@end
