//
//  MJRMarsRover.m
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRMarsRover.h"
#import "MJRPhotoReference.h"

@interface MJRMarsRover()

@property (nonatomic, readwrite, nonnull) NSMutableArray<MJRPhotoReference *> *internalPhotoReferences;

@end

@implementation MJRMarsRover

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    });
    return dateFormatter;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _landingDate = [[[self class] dateFormatter] dateFromString:dictionary[@"landing_date"]];
        _launchDate = [[[self class] dateFormatter] dateFromString:dictionary[@"launch_date"]];
        _maxSol = [dictionary[@"maxSol"] intValue];
        _totalPhotos = [dictionary[@"total_photos"] intValue];

        [self convertToPhotoReferenceArray:dictionary[@"photos"]];
    }
    return self;
}

- (void)convertToPhotoReferenceArray:(NSArray *)array {
    for (NSDictionary *photoRef in array) {
        [self.internalPhotoReferences addObject:[[MJRPhotoReference alloc] initWithDictionary:photoRef]];
    }
    [self.internalPhotoReferences copy];
}

@end
