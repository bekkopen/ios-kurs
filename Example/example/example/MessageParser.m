//
//  MessageParser.m
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import "MessageParser.h"
#import "Message.h"

@implementation MessageParser

- (NSArray *)createMessagesFromJSON:(NSData *)messagesJSON error:(NSError **)error
{
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:messagesJSON options:kNilOptions error:error];
    
    if (error)
    {
        return [NSArray array];
    }
    
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSDictionary *messageJSON in jsonObjects)
    {
        Message *message = [[Message alloc] init];
        message.from = [messageJSON objectForKey:@"from"];
        message.message = [messageJSON objectForKey:@"message"];
        
        [messages addObject:message];
    }
    

    return [NSArray arrayWithArray:messages];
}

@end
