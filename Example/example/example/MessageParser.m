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
    NSString *string = [[NSString alloc] initWithData:messagesJSON encoding: NSASCIIStringEncoding];
    messagesJSON = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:messagesJSON options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonError];
    
    if (jsonError != nil)
    {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Failed parsing JSON" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"parse" code:500 userInfo:errorDetail];
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
