//
//  KRCSOL.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRCSOL : NSObject

@property (nonatomic, nonnull, readonly) NSNumber *sol;

- (instancetype _Nonnull)initWithSol:(NSNumber * _Nonnull)sol;

@end
