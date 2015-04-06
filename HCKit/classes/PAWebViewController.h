//
//  PAOpSeatWebViewController.h
//  PAQZZ
//
//  Created by 花晨 on 13-12-18.
//  Copyright (c) 2013年 平安付. All rights reserved.
//
#import "BABasicViewController.h"

@interface PAWebViewController : BABasicViewController <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, strong) NSString *linkUrl;
@property (weak, nonatomic) UINavigationController *backNavigationController;
@property (nonatomic, assign) BOOL showToolBar;
@property (nonatomic, assign) BOOL backActionForPrevWebPage;
@property (nonatomic, strong) NSString *navigationbarTitle;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIBarButtonItem *buttonGoBack;
@property (nonatomic, strong) UIBarButtonItem *buttonGoForward;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) BOOL scalesPageToFit;
@property (nonatomic, assign) BOOL shouldHiddenNavigationBar;
@property (nonatomic, assign) BOOL handresetVerticalScroll;
@property (nonatomic, assign) BOOL showHUD;

@property (nonatomic, strong) UIView *footerView;

- (id)initWithUrl:(NSString *)urlString showToolBar:(BOOL)yesOrno;
- (id)initWithMutableURLRequest:(NSMutableURLRequest *)urlRequest showToolBar:(BOOL)yesOrno;
@end
