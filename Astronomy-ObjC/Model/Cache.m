//
//  Cache.m
//  Astronomy-ObjC
//
//  Created by Chad Parker on 2020-08-10.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "Cache.h"

@interface Cache ()

@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) NSMutableDictionary *cache;

@end

@implementation Cache

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create("com.LambdaSchool.Astronomy.CacheQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cacheValue:(id)value for:(int)key
{
    dispatch_async(self.queue, ^{
        self.cache[@(key)] = value;
    });
}

- (id)valueForKey:(int)key
{
    __block id value = nil;
    dispatch_sync(self.queue, ^{
        value = self.cache[@(key)];
    });
    return value;
}

@end
