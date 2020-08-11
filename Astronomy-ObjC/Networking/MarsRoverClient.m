//
//  MarsRoverClient.m
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/7/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "MarsRoverClient.h"
#import "Astronomy_ObjC-Swift.h"

static NSString *const MarsPhotosBaseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const MarsPhotosAPIKeyString = @"qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7";

@implementation MarsRoverClient

- (void)fetchMarsRoverNamed:(NSString *)name completionHandler:(FetchMarsRoverCompletionHandler)completionHandler
{
    NSURL *url = [self urlForRover:name];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching rover: %@", error);

            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });

            return;
        }

        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (!dictionary) {
            NSLog(@"Error decoding JSON: %@", jsonError);

            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });

            return;
        }

        MarsRover *rover = [MarsRover newRoverFrom:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(rover, nil);
        });
        
    }] resume];
}

- (NSURL *)urlForRover:(NSString *)roverName
{
    NSURL *baseURL = [NSURL URLWithString:MarsPhotosBaseURLString];
    NSURL *url = [[baseURL URLByAppendingPathComponent:@"manifests"] URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:MarsPhotosAPIKeyString]];
    return urlComponents.URL;
}

- (NSURL *)urlForPhotosFromRover:(NSString *)roverName onSol:(int)sol
{
    NSURL *baseURL = [NSURL URLWithString:MarsPhotosBaseURLString];
    NSURL *url = [[[baseURL URLByAppendingPathComponent:@"rovers"]
                            URLByAppendingPathComponent:roverName]
                            URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d", sol]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:MarsPhotosAPIKeyString],
    ];
    return urlComponents.URL;
}

@end
