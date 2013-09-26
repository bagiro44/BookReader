//
//  TestDel.h
//  BookReader
//
//  Created by Dmitriy Remezov on 19.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SampleProtocolDelegate <NSObject>
@required
- (void) processCompleted;
@end

@interface TestDel : NSObject
{
    id <SampleProtocolDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;

- (void) startSampleProcess;

@end
