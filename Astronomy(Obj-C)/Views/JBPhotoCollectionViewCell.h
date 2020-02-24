//
//  JBPhotoCollectionViewCell.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBPhotoReference;
@class JBPhotoController;


NS_SWIFT_NAME(PhotoCollectionViewCell)
@interface JBPhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, nullable) IBOutlet UIImageView *imageView;
@property (weak, nonatomic, nullable) JBPhotoReference *photoRef;

@end

