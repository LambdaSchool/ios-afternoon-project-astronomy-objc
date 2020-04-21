//
//  MJRConcurrentOperation.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/15/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJRConcurrentOperation : NSOperation

typedef NS_ENUM(NSInteger, State) {
    MJRIsReady,
    MJRIsExecuting,
    MJRIsFinished
};

@property State state;
@property dispatch_queue_t stateQueue;

@end

NS_ASSUME_NONNULL_END
