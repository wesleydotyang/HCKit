//
//  BABasicViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicViewController.h"
#import "extobjc.h"
#import "UIBarButtonItem+Extend.h"
#import "HCKit.h"
#import "UIView+BlocksKit.h"

#define kBarRightButtonTitleColor_new UIColorFromRGB(0x1d1d1d)

@interface BABasicViewController ()
@property (nonatomic,assign) BOOL isNavigationBarHiddenSet;

@end

@implementation BABasicViewController
@synthesize navigationBarHidden = _navigationBarHidden;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _toolbarHidden = YES;
    _isNavigationBarHiddenSet = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                BABasicViewController *preController = self.navigationController.viewControllers[idx-1];
                if ([preController isKindOfClass:[BABasicViewController class]]) {
                    return preController.navigationBarHidden;
                }
            }
        }
    }
    return _navigationBarHidden;
}

-(BOOL)isModal
{
    BOOL isModal = ((self.parentViewController && self.parentViewController.presentedViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.presentedViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.presentedViewController == self) ||
                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.presentedViewController == self.navigationController) ||
                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;
}

- (void)setIsLeftCancelBtn:(BOOL)isLeftCancelBtn
{
    if (isLeftCancelBtn)
    {
        @weakify(self);
        UIBarButtonItem * leftButton = [UIBarButtonItem barButtonItemWithTitle:@"取消" block:^{
            @strongify(self);
            if ([self isModal]) {
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        if (isIOS7AndBeyond())
        {
            negativeSpacer.width = -10;
        } else {
            negativeSpacer.width = 10;
        }
        
        self.navigationItem.backBarButtonItem = nil;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftButton];
    } else {
        self.navigationItem.backBarButtonItem = nil;
        self.navigationItem.leftBarButtonItems = nil;
    }
}
- (UIButton *)setupRightBtnWithTitle:(NSString *)title withTapped:(void(^)(void))tappedBlock{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = (CGRect){{0, 0}, {60,40}};
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:kBarRightButtonTitleColor_new forState:UIControlStateNormal];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
