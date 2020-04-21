//
//  MJRFetchPhotoOperation.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/15/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRConcurrentOperation.h"

@class MJRPhotoReference;

NS_ASSUME_NONNULL_BEGIN

@interface MJRFetchPhotoOperation : MJRConcurrentOperation

@property MJRPhotoReference *photoReference;

- (instancetype)initWithPhotoReference:(MJRPhotoReference *)photoReference;

@end

NS_ASSUME_NONNULL_END
