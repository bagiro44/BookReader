
//
//  TestDel.m
//  BookReader
//
//  Created by Dmitriy Remezov on 19.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "TestDel.h"

@implementation TestDel

- (void) startSampleProcess
{
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self.delegate selector:@selector(processCompleted) userInfo:nil repeats:NO];
    
}

@end
