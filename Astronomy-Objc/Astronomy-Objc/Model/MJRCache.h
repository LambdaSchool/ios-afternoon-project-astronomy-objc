//
//  MJRCache.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/15/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJRCache<Key, Value> : NSObject

- (void)cache:(NSValue *)value forKey:(Key *_Nullable)key;

@end

NS_ASSUME_NONNULL_END
