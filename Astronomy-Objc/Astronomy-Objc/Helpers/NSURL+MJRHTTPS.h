//
//  NSURL+MJRHTTPS.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/16/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (MJRHTTPS)

@property (readonly) NSURL *usingHTTPS;

@end

NS_ASSUME_NONNULL_END
