//
//  Camera.h
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/5/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic) int identifier;
@property (nonatomic) int roverId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
