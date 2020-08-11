//
//  ImageCollectionViewCell.m
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/5/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCollectionViewCell


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
