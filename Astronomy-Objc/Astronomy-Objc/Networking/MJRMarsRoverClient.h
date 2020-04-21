//
//  MJRMarsRoverClient.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJRMarsRover;
@class MJRPhotoReference;

typedef void(^roverCompletion)(MJRMarsRover *_Nullable, NSError *_Nullable);
typedef void(^photoCompletion)(NSArray<MJRPhotoReference *> *_Nullable, NSError *_Nullable);

NS_SWIFT_NAME(MarsRoverClient)
NS_ASSUME_NONNULL_BEGIN


@interface MJRMarsRoverClient : NSObject

- (NSURL *)urlForRoverInfo:(NSString *)roverName;
- (NSURL *)urlForPhotosFromRover:(NSString *)roverName andSol:(int)sol;

- (void)fetchRoverNamed:(NSString *)roverName completion:(roverCompletion)completion;
- (void)fetchPhotosFromRoverNamed:(NSString *)rover onSol:(int)sol completion:(photoCompletion)completion;

@end

NS_ASSUME_NONNULL_END
