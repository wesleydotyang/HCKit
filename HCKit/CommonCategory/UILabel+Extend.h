//
//  UILabel+Extend.h
//  PAQZZ
//
//  Created by Chenny Shan on 5/26/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extend)

- (void)sizeToFitFixedWidth:(CGFloat)width;

/**
 *  获取每一行的text
 */
- (NSArray*)separatedLines;

@end
