//
//  TwitterpostTests.m
//  TwitterpostTests
//
//  Created by Eivind Bergstøl on 5/9/12.
//  Copyright (c) 2012 Bekk Consulting as. All rights reserved.
//

#import "TwitterpostTests.h"

@implementation TwitterpostTests

- (void)setUp
{
    [super setUp];
    self.minString = @"Dette er fett";
}

- (void)tearDown
{
    self.minString = nil;
    [super tearDown];
}

- (void)testExample
{
    STAssertNotNil(self.minString, @"Denne skal være satt");
}

@synthesize minString;

@end
