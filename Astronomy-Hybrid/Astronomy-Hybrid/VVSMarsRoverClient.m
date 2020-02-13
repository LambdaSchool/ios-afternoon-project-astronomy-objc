//
//  VVSMarsRoverClient.m
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSMarsRoverClient.h"
#import "Astronomy_Hybrid-Swift.h"
#import <UIKit/UIKit.h>

@interface VVSMarsRoverClient ()

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, readonly) NSString *apiKey;

@end

@implementation VVSMarsRoverClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = [[NSURL alloc] initWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
        _apiKey = @"xKpfIwh6zZhhKSHnoOum4B14iQG3W7XXRlOY4k8U";
    }
    return self;
}

- (NSURL *)urlForInfoForReover:(NSString *)roverName
{
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *api = [NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey];
    [urlComponents setQueryItems:@[api]];
    return urlComponents.URL;
}

- (NSURL *)urlforPhotosFromRover:(NSString *)roverName sol:(NSInteger)sol
{
    NSURL *url = self.baseURL;
    [url URLByAppendingPathComponent:@"rovers"];
    [url URLByAppendingPathComponent:roverName];
    [url URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSString *solString = [[NSString alloc] initWithFormat:@"%ld", (long)sol];
    NSURLQueryItem *solQueryItem = [NSURLQueryItem queryItemWithName:@"sol" value:solString];
    NSURLQueryItem *api = [NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey];
    [urlComponents setQueryItems: @[solQueryItem, api]];
    return urlComponents.URL;
}

-(void)fetchFromURL:(NSURL *)url
            session:(NSURLSession * _Nullable)session
         completion:(void (^)(id _Nullable object, NSError * _Nullable error))completion
{
    if (session == nil) {
        session = [NSURLSession sharedSession];
    }
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSLog(@"Data was nil");
            completion(nil, [[NSError alloc] init]);
            return;
        }
    
        NSError *anError = nil;
        id decodedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&anError];
        if (anError != nil) {
            completion(nil, anError);
            return;
        }
        
        completion(decodedObject, nil);
    }] resume];
}

- (void)fetchMarsRoverWithName:(NSString *)name
                       session:(NSURLSession * _Nullable)session
                    completion:(void (^)(VVSMarsRover * _Nullable marsRover, NSError * _Nullable error))completion
{
    if (session == nil) {
        session = [NSURLSession sharedSession];
    }
    
    NSURL *url = [self urlForInfoForReover:name];
    [self fetchFromURL:url session:session completion:^(id  _Nullable object, NSError * _Nullable error) {
        NSDictionary *dictionary = object;
        VVSMarsRover *rover = dictionary[@"photo_manifest"];
        
        if (rover != nil) {
            completion(rover, nil);
        } else {
            completion(nil, error);
        }
    }];
    
}

- (void)fetchPhotosFrom:(VVSMarsRover *)rover
                  onSol:(NSInteger)sol
                session:(NSURLSession * _Nullable)session
             completion:(void (^)(NSArray<MarsPhotoReference *> * _Nullable marsPhotoReference, NSError * _Nullable error))completion
{
    
}

@end
