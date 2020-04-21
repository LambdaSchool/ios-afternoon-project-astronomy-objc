//
//  MJRFetchPhotoOperation.m
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/15/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRFetchPhotoOperation.h"

@interface MJRFetchPhotoOperation()

@property NSURLSessionDataTask *dataTask;

@end

@implementation MJRFetchPhotoOperation

- (instancetype)initWithPhotoReference:(MJRPhotoReference *)photoReference {
    if (self = [super init]) {
        self.photoReference = photoReference;
    }
    return self;
}

- (void)start {
    self.state = MJRIsExecuting;
}

- (void)fetchPhoto {
//    NSURL *url = self.photoReference
};





@end
