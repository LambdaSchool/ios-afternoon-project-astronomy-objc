//
//  KMLManifest.m
//  Astronomy_ObjectiveC
//
//  Created by Mark Poggi on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLManifest.h"
#import "KMLSol.h"

@implementation KMLManifest

- (instancetype)initWithRoverName: (NSString *)roverName solIDs:(NSArray *)sols {
    self = [super init];
    if (self) {
        _roverName = roverName;
        _solIDs = sols;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (dictionary) {
        if (dictionary[@"photo_manifest"] != [NSNull null]) {
            NSDictionary *roverDictionary = dictionary[@"photo_manifest"];
            NSString *roverName = roverDictionary[@"name"];
            NSArray *solArray = roverDictionary[@"photos"];

            NSMutableArray *solOutputArray = [[NSMutableArray alloc] init];
            for (int i=0; i < solArray.count; i++) {
                NSNumber *sol = solArray[i][@"sol"];
                [solOutputArray addObject: sol];
            }

            self = [self initWithRoverName:roverName solIDs:solOutputArray];
            return self;
        }


    }
    return nil;
}

-(void)addSol:(KMLSol *)sol
{
    if(!_sols) {
        _sols = [[NSMutableArray alloc] init];
    }
    [_sols addObject:sol];
}

@end
