//
//  UIBarButtonItem+Extend.h
//  PAQZZ
//
//  Created by chendailong2014@126.com on 14-4-4.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extend)
+ (instancetype)backBarButtonItemWithBlock:(void(^)())block;
//+ (instancetype)backBarButtonItemWhiteStyleWithBlock:(void(^)())block;//蛋疼的白色style
+ (instancetype)barButtonItemWithTitle:(NSString *)title block:(void(^)())block;
+ (instancetype)barButtonItemWithImageName:(NSString *)imageName block:(void (^)())block;
@end
