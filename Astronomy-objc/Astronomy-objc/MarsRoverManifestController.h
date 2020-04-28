//
//  MarsRoverManifestController.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Rover.h"

@class MarsRoverPhotos;

typedef void(^MissionManifestCompletionHandler)(Rover *_Nullable rover, NSError *_Nullable error);
typedef void(^FetchAllPhotosCompletionHandler)(MarsRoverPhotos *_Nullable rover, NSError *_Nullable error);
typedef void(^SingleImageCompletionHandler)(UIImage *_Nullable image, NSError *_Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface MarsRoverManifestController : NSObject

- (void)fetchMissionManifestWithCompletionHandler:(MissionManifestCompletionHandler)completionHandler;

- (void)fetchAllPhotosForSol:(int)sol WithCompletionHandler:(FetchAllPhotosCompletionHandler)completionHandler;

- (void)fetchSingleImage:(NSString *)imageURLString WithCompletionHandler:(SingleImageCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
