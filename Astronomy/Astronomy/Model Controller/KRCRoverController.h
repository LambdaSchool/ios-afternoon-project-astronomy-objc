//
//  KRCRoverController.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KRCSOL.h"
typedef void (^KRCRoverCompletion)(NSError * _Nullable);

NS_SWIFT_NAME(RoverController)
@interface KRCRoverController : NSObject

@property (nonatomic, nonnull, copy, readonly) NSArray<KRCSOL *> *sols;
@property (nonatomic, nonnull, copy, readonly) NSArray *photoURLs;

- (NSArray * _Nonnull)sols;

- (void)fetchSolWithCompletion:(KRCRoverCompletion _Nonnull)completion;

- (void)fetchPhotosFromSol:(NSNumber * _Nonnull)sol completion:(KRCRoverCompletion _Nonnull)completion;

- (void)parseSolJson:(NSDictionary * _Nonnull)json;

- (void)parsePhotoJson:(NSDictionary * _Nonnull)json;
@end
