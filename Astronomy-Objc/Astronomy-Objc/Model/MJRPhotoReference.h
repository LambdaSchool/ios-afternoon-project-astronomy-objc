//
//  MJRPhotoReference.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;

NS_ASSUME_NONNULL_BEGIN

@interface MJRPhotoReference : NSObject

@property int sol;
@property int totalPhotos;
@property NSArray <Camera *> *cameras;
@property NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
