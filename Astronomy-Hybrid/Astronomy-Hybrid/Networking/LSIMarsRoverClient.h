//
//  LSIMarsRoverClient.h
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIMarsRover;
@class MarsPhotoReference;

NS_SWIFT_NAME(MarsRoverClient)
@interface LSIMarsRoverClient : NSObject

@property (nonnull, readonly) NSURL *baseURL;
@property (nonnull, readonly) NSString *apiKey;

- (void)fetchFromURL:(nonnull NSURL *)url
          completion:(void (^_Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))completion;

- (void)fetchMarsRoverNamed:(nonnull NSString *)name
                 completion:(void (^_Nonnull)(LSIMarsRover * _Nullable, NSError * _Nullable error))completion;

- (void)fetchPhotosFromRover:(nonnull LSIMarsRover *)rover
                       onSol:(int)sol completion:(void (^_Nonnull)(NSArray<MarsPhotoReference *> * _Nullable photos, NSError * _Nullable error))completion;

@end
