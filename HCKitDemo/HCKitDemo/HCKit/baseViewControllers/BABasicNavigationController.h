//
//  BABasicNavigationViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BABasicViewController.h"
#import "BABasicTableViewController.h"
#import "HTDelegateProxy.h"

@interface BABasicNavigationController : UINavigationController<UINavigationBarDelegate>
@property (strong, nonatomic) HTDelegateProxy* delegateProxy;

@end
