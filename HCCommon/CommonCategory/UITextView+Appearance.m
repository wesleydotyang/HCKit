//
//  UITextView+Appearance.m
//  PAQZZ
//
//  Created by Wang Yandong on 13-9-11.
//  Copyright (c) 2013年 平安付. All rights reserved.
//

#import "UITextView+Appearance.h"

@implementation UITextView (Appearance)

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}


@end
