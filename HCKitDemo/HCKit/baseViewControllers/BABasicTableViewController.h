//
//  BABasicTableViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BABasicTableViewController : UITableViewController
@property (assign, nonatomic) BOOL navigationBarHidden;
@property (assign, nonatomic) BOOL toolbarHidden;
- (UIButton *)setupRightBtnWithTitle:(NSString *)title withTapped:(void(^)(void))tappedBlock;

@end
