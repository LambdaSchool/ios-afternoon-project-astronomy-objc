//
//  MarsPhoto.h
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/5/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;

NS_ASSUME_NONNULL_BEGIN

@interface MarsPhoto : NSObject

@property (nonatomic) int identifier;
@property (nonatomic) int sol;
@property (nonatomic) Camera *camera;
@property (nonatomic) NSDate *earthDate;
@property (nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
