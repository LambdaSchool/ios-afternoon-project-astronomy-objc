//
//  Cache.h
//  Astronomy-ObjC
//
//  Created by Chad Parker on 2020-08-10.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cache : NSObject

- (void)cacheValue:(id)value for:(int)key;
- (nullable id)valueForKey:(int)key;

@end

NS_ASSUME_NONNULL_END
