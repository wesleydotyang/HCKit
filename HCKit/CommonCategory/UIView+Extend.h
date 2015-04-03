//
//  UIView+Extend.h
//  PAQZZ
//
//  Created by 张佳俊 on 14-4-17.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extend)

+(UIView *)snapshotOfView:(UIView*)view;
- (void)startShimmering;
- (void)stopShimmering;

@end
