//
//  MJRMarsRoverClient.m
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRMarsRoverClient.h"
#import "MJRMarsRover.h"
#import "MJRPhotoReference.h"

@interface MJRMarsRoverClient()


@end

@implementation MJRMarsRoverClient

NSString *baseURL = @"https://api.nasa.gov/mars-photos/api/v1";
NSString *apiKey = @"rqFxG9V1Zfmqi9PBziYikxYx3JJ3GIUPI2ilwPfa";

- (void)fetchRoverNamed:(NSString *)roverName completion:(void (^)(MJRMarsRover *rover, NSError *error))completion {
    NSURL *requestURL = [self urlForRoverInfo:roverName];

    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error fetching rover: %@", error);
            completion(nil, error);
            return;
        }

        if (data == nil) {
            NSLog(@"No data was returned from data task");
            completion(nil, [[NSError alloc] init]);
            return;
        }

        NSError *jsonError;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        if (jsonError) {
            NSLog(@"NSJSONSerialization error: %@", jsonError);
            completion(nil, jsonError);
            return;
        }

        NSLog(@"%@", jsonDict);

        NSDictionary *roverDict = jsonDict[@"photo_manifest"];
        if (roverDict != (id) [NSNull null]) {
            MJRMarsRover *marsRover = [[MJRMarsRover alloc] initWithDictionary:roverDict];
            NSLog(@"%@", marsRover);
            completion(marsRover, nil);
        } else {
            NSLog(@"roverDict error: %@", error);
            completion(nil, error);
        }

    }];
    [dataTask resume];
}






- (NSURL *)urlForRoverInfo:(NSString *)roverName {
    NSURL *url = [NSURL URLWithString:baseURL];
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    [urlComponents setQueryItems:@[apiQuery]];
    return urlComponents.URL;
}

- (NSURL *)urlForPhotosFromRover:(NSString *)roverName andSol:(int)sol {
    NSURL *url = [NSURL URLWithString:baseURL];
    NSString *solStr = [NSString stringWithFormat:@"%d", sol];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *solQuery = [NSURLQueryItem queryItemWithName:@"sol" value:solStr];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    [urlComponents setQueryItems:@[solQuery, apiQuery]];
    return urlComponents.URL;
}




@end
