//
//  BABasicTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicTableViewController.h"
#import "UIView+BlocksKit.h"

@interface BABasicTableViewController ()
@property (nonatomic,assign) BOOL isNavigationBarHiddenSet;

@end

@implementation BABasicTableViewController
@synthesize navigationBarHidden = _navigationBarHidden;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isNavigationBarHiddenSet = NO;
    _toolbarHidden = YES;


}

-(void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    _navigationBarHidden = navigationBarHidden;
    _isNavigationBarHiddenSet = YES;
    
}


-(BOOL)navigationBarHidden
{
    if (self.isNavigationBarHiddenSet) {
        return _navigationBarHidden;
    }else{
        if (self.navigationController) {
            NSUInteger idx = [self.navigationController.viewControllers indexOfObject:self];
            if (idx!=NSNotFound && idx>0) {
                BABasicTableViewController *preController = self.navigationController.viewControllers[idx-1];
                if ([preController isKindOfClass:[BABasicTableViewController class]]) {
                    return preController.navigationBarHidden;
                }
            }
        }
    }
    return _navigationBarHidden;
}

- (UIButton *)setupRightBtnWithTitle:(NSString *)title withTapped:(void(^)(void))tappedBlock{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = (CGRect){{0, 0}, {60,40}};
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    if (tappedBlock) {
        [rightBtn bk_whenTapped:^{
            tappedBlock();
            
        }];
    }
    self.navigationItem.rightBarButtonItem = barItem(rightBtn);
    return rightBtn;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
