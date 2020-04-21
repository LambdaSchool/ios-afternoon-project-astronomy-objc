//
//  NSURL+MJRHTTPS.m
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/16/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "NSURL+MJRHTTPS.h"

@implementation NSURL (MJRHTTPS)

- (NSURL *)usingHTTPS {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    return components.URL;
}

@end
