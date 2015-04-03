//
//  BABasicViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewUtils.h"
@interface BABasicViewController : UIViewController

@property (assign, nonatomic) BOOL navigationBarHidden;
@property (assign, nonatomic) BOOL toolbarHidden;
- (void)setIsLeftCancelBtn:(BOOL)isLeftCancelBtn;
- (UIButton *)setupRightBtnWithTitle:(NSString *)title withTapped:(void(^)(void))tappedBlock;

@end
