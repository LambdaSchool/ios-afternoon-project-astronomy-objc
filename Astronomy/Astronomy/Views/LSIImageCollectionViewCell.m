//
//  LSIImageCollectionViewCell.m
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSIImageCollectionViewCell.h"

@implementation LSIImageCollectionViewCell

- (void)prepareForReuse
{
    self.marsImageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
