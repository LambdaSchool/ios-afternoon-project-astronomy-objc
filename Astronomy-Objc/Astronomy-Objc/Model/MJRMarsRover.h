//
//  MJRMarsRover.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Camera;
@class MJRPhotoReference;

@interface MJRMarsRover : NSObject

@property NSString *name;
@property NSDate *landingDate;
@property NSDate *launchDate;
@property int maxSol;
@property int totalPhotos;
@property (nonatomic, readonly, nonnull) NSArray <MJRPhotoReference *> *photoReferences;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
