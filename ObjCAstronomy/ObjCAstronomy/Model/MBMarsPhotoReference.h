//
//  MBMarsPhotoReference.h
//  ObjCAstronomy
//
//  Created by Mitchell Budge on 7/23/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMarsPhotoReference : NSObject

@property NSInteger identifier;
@property NSInteger sol;
@property Camera *camera;
@property NSDate *earthDate;
@property NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
