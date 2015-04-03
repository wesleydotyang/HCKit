//
//  UITableView+Appearance.m
//  PAQZZ
//
//  Created by Wang Yandong on 10/17/13.
//  Copyright (c) 2013 平安付. All rights reserved.
//

#import "UITableView+Appearance.h"

@implementation UITableView (Appearance)

- (void)setBackgroundViewColor:(UIColor *)backgroundColor
{
    if (nil == self.backgroundView)
    {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        backgroundView.backgroundColor = backgroundColor;
        self.backgroundView = backgroundView;
    }
    
    if ([self.backgroundView isKindOfClass:[UIImageView class]])
    {
        return;
    }
    
    self.backgroundView.backgroundColor = backgroundColor;
}

@end
