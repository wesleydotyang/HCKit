//
//  BABasicNavigationViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicNavigationController.h"
#import "HCUtilityFuc.h"
#import "HCUtilityMacro.h"
@interface BABasicNavigationController ()

@end

@implementation BABasicNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (isIOS7AndBeyond()) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
//    UIImage *backgroundImage =imageWithColor(CGSizeMake(640, 128), UIColorFromRGB(0xeb5312));
    
//    UIImage *image = [UIImage imageNamed:@"navigation_bg"];
//    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:17], UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]}];

    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xeb5312)];
    self.navigationBar.translucent = NO;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    self.delegateProxy = [[HTDelegateProxy alloc] initWithDelegates:@[ self, delegate ]];
    super.delegate = (id)self.delegateProxy;
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    //    NSLog(@"pushViewController:%@",NSStringFromClass([viewController class]));
//    if (self.controllers==nil) {
//        self.isInTransition = NO;
//        self.pendingOperation = [NSMutableArray array];
        self.delegateProxy = [[HTDelegateProxy alloc] initWithDelegates:@[ self ]];
		super.delegate = (id)self.delegateProxy;
//        self.controllers = [[PAStack alloc] init];
//        self.pushedController = (PABasicViewController*)viewController;
//        
//    }
//    
//    
//    if (self.isInTransition == YES) {
//        NSLog(@"pushing pending");
//        @weakify(self);
//        void(^block)() = ^{
//            @strongify(self);
//            [self pushViewController:viewController animated:animated];
//        };
//        [self.pendingOperation addObject:[PANavigationOperation operation:block animated:animated]];
//    }else{
//        if (animated) {
//            self.isInTransition = YES;
//        }
//        self.pushedController = (PABasicViewController*)viewController;
//        [self.controllers push:viewController];
        [super pushViewController:viewController animated:animated];
//    }
}

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    //[UIApplication sharedApplication].statusBarHidden = YES;
    if ([viewController isKindOfClass:[ BABasicViewController class]]) {
         BABasicViewController *vc = ( BABasicViewController*)viewController;
        //        [self setStatusBarHidden:vc.statusBarHidden];
        [self setNavigationBarHidden:vc.navigationBarHidden toolbarHidden:vc.toolbarHidden animated:animated];
    }else if ([viewController isKindOfClass:[BABasicTableViewController class]]){
        BABasicTableViewController  *tvc = (BABasicTableViewController *)viewController;
        [self setNavigationBarHidden:tvc.navigationBarHidden toolbarHidden:tvc.toolbarHidden animated:animated];
    }
    
}
#pragma mark - Private



- (void)setNavigationBarHidden:(BOOL)navigationBarHidden toolbarHidden:(BOOL)toolbarHidden animated:(BOOL)animated
{
	[super setNavigationBarHidden:navigationBarHidden animated:animated];
	[super setToolbarHidden:toolbarHidden animated:animated];
}


@end
