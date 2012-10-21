//
//  MessageParser.m
//  example
//
//  Created by Hans Magnus Inderberg on 9/19/12.
//  Copyright (c) 2012 Hans Magnus Inderberg. All rights reserved.
//

#import <library/library.h>
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
        return @[];
    }
    
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSDictionary *messageJSON in jsonObjects)
    {
        Message *message = [[Message alloc] init];
        message.from = messageJSON[@"from"];
        message.message = messageJSON[@"message"];
        
        NSString *dateString = messageJSON[@"date"];        
 
        if (dateString != nil && ![dateString isKindOfClass:[NSNull class]]) {
            message.date = [NSDate dateFromZuluTimeString:dateString];  
        }        

        [messages addObject:message];
    }
    

    return [NSArray arrayWithArray:messages];
}

- (NSData *)createJSONFromMessage:(Message *)message error:(NSError **)error
{
    NSString *dateString = [NSDateFormatter localizedStringFromDate:message.date
                                   dateStyle:NSDateFormatterLongStyle
                                   timeStyle:NSDateFormatterLongStyle];
    
    NSDictionary* messageDict = @{
        @"from": message.from,
        @"message": message.message,
        @"date": dateString
    };
    
    NSError *jsonError;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:messageDict 
                                                       options:NSJSONWritingPrettyPrinted error:&jsonError];
    
    if (jsonError != nil)
    {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Failed converting to JSON" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"parse" code:500 userInfo:errorDetail];
        return [NSData data];
    }
    
    return jsonData;
}

@end
