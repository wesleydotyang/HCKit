//
//  UIImage+ImageBlur.h
//  PAQZZ
//
//  Created by Luyao Lai on 5/6/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageBlur)
- (UIImage*)imageWithGaussianBlur:(CGFloat)blurRadius;
@end
