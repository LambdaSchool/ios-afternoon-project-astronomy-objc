//
//  MJRConcurrentOperation.m
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/15/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRConcurrentOperation.h"

@interface MJRConcurrentOperation()

@property State internalState;

@end

@implementation MJRConcurrentOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.internalState = MJRIsReady;
    }
    return self;
}

- (State)state {
    __block State result;
    dispatch_queue_t queue = self.stateQueue;
    dispatch_sync(queue, ^{
        result = self.internalState;
    });
    return result;
}

- (void)setState:(State)state {
    State oldValue = self.state;
    [self willChangeValueForKey:[self returnStateString:state]];
    [self willChangeValueForKey:[self returnStateString:oldValue]];

    dispatch_sync(_stateQueue, ^{
        self.state = state;
    });

    [self didChangeValueForKey:[self returnStateString:oldValue]];
    [self didChangeValueForKey:[self returnStateString:state]];
}

- (NSString *)returnStateString:(State)state {
    switch (state) {
        case MJRIsReady:
            return @"MJRIsReady";
        case MJRIsFinished:
            return @"MJRIsFinished";
        case MJRIsExecuting:
            return @"MJRIsExecuting";
    }
}


- (BOOL)isReady {
    return (super.isReady && self.state == MJRIsReady);
}

- (BOOL)isFinished {
    return self.state == MJRIsFinished;
}

-(BOOL)isExecuting {
    return self.state == MJRIsExecuting;
}

- (BOOL)isAsynchronous {
    return YES;
}


@end
