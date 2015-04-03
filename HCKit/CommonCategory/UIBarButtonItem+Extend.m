//
//  UIBarButtonItem+Extend.m
//  PAQZZ
//
//  Created by chendailong2014@126.com on 14-4-4.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"
#import "UIView+BlocksKit.h"

#define BAR_BUTTON_MIN_WIDTH 40
#define BAR_BUTTON_MIN_HEIGHT 60
#define BAR_BUTTON_FONT_SIZE 14
@implementation UIBarButtonItem (Extend)
+ (instancetype)backBarButtonItemWithBlock:(void(^)())block
{
    UIImage *backgroundImage = [UIImage imageNamed:pBackArrowImageName_new];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [leftButton sizeToFit];
    [leftButton bk_whenTapped:^{
        block();
    }];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    barButtonItem.width = leftButton.size.width;
    return barButtonItem;
}
//+ (instancetype)backBarButtonItemWhiteStyleWithBlock:(void(^)())block
//{
//    UIImage *backgroundImage = [UIImage imageNamed:pBackArrowImageName];
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
//    [leftButton sizeToFit];
//    [leftButton bk_whenTapped:^{
//        block();
//    }];
//    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    barButtonItem.width = leftButton.size.width;
//    return barButtonItem;
//}


+ (instancetype)barButtonItemWithTitle:(NSString *)title block:(void(^)())block
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:kBarRightButtonTitleColor_new forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:BAR_BUTTON_FONT_SIZE];
    [rightButton sizeToFit];
    
    CGSize size = rightButton.size;
    size.width  = size.width  < BAR_BUTTON_MIN_WIDTH  ? BAR_BUTTON_MIN_WIDTH  : size.width;
    size.height = size.height < BAR_BUTTON_MIN_HEIGHT ? BAR_BUTTON_MIN_HEIGHT : size.height;
    rightButton.frame = (CGRect){{0, 0}, size};
    
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton bk_whenTapped:^{
        block();
    }];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    barButtonItem.width = rightButton.size.width;
    return barButtonItem;
}

+ (instancetype)barButtonItemWithImageName:(NSString *)imageName block:(void (^)())block
{
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [imageButton setBackgroundImage:image forState:UIControlStateNormal];
    [imageButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [imageButton sizeToFit];
    
    [imageButton bk_whenTapped:^{
        block();
    }];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
    barButtonItem.width = imageButton.size.width;
    return barButtonItem;
}

@end
