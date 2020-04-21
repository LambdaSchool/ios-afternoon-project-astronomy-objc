//
//  Astronomy_ObjcNetworkTests.m
//  Astronomy-ObjcNetworkTests
//
//  Created by Marlon Raskin on 10/15/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "MJRMarsRover.h"

@class MJRMarsRover;

@interface Astronomy_ObjcNetworkTests : XCTestCase

@end

@implementation Astronomy_ObjcNetworkTests

- (void)testRover {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSData *data = loadFile(@"Rover.json", bundle);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    XCTAssertNil(error);
    NSLog(@"Error: %@", error);
    NSLog(@"JSON: %@", json);

    NSDictionary *roverDict = json[@"photo_manifest"];
    MJRMarsRover *rover = [[MJRMarsRover alloc] initWithDictionary:roverDict];
    NSLog(@"rover: %@", rover);

    XCTAssertNotNil(rover);
    XCTAssertEqualObjects(@"Curiosity", rover.name);
    XCTAssertEqual(366206, rover.totalPhotos);

}

- (void)testPhoto {

}

@end
