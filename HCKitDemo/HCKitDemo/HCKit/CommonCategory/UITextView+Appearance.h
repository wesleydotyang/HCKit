//
//  UITextView+Appearance.h
//  PAQZZ
//
//  Created by Wang Yandong on 13-9-11.
//  Copyright (c) 2013年 平安付. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Appearance)

- (void)setCornerRadius:(CGFloat)cornerRadius UI_APPEARANCE_SELECTOR;
- (void)setBorderColor:(UIColor *)borderColor UI_APPEARANCE_SELECTOR;
- (void)setBorderWidth:(CGFloat)borderWidth UI_APPEARANCE_SELECTOR;

@end
