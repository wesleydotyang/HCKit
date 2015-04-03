//
//  PAOpSeatWebViewController.m
//  PAQZZ
//
//  Created by 花晨 on 13-12-18.
//  Copyright (c) 2013年 平安付. All rights reserved.
//
#define kToolBarHeight  44
#define HUD_WEBLODING @"载入中..."
#import "PAWebViewController.h"
#import "UIDevice+Resolutions.h"
#import "BABasicNavigationController.h"
#import "PAHUD.h"
#import "PAHUDService.h"
#import "SIAlertView.h"
#define k_loading_HUD                    @"努力加载中..."

@interface PAWebViewController (){
    NSMutableURLRequest *_request;
    UINavigationBar *navigationBarModal; // Only used in modal mode
    NSURLRequest *errorRequest;
    
    CGSize _contentSize;
}
@property(nonatomic,assign) UIWebViewNavigationType navigationType;
@property(nonatomic,copy) NSString *navigationUrl;
@end

@implementation PAWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initWebView];
    }
    return self;
}

-(id)initWithUrl:(NSString *)urlString showToolBar:(BOOL)yesOrno {
    self = [self init];
    if (self) {
        _linkUrl = urlString;
//        _linkUrl = @"www.baidu.com";
        _showToolBar = yesOrno;
    }
    return self;
}

-(id)initWithMutableURLRequest:(NSMutableURLRequest*)urlRequest showToolBar:(BOOL)yesOrno {
    self = [self init];
    if (self) {
        _request = urlRequest;
        _showToolBar = yesOrno;
    }
    return self;
}

//- (void)backAction:(id)sender
//{
////    if([self isModal]){
////        [self dismisspresentedViewControllerAnimated:YES];
////        return;
////    }
//    [self.navigationController popViewControllerAnimated:YES];
//
//    if (self.backActionForPrevWebPage && _webView) {
//        if (_webView.canGoBack) {
//            [_webView goBack];
//            [self toggleBackForwardButtons];
//        }
//        else {
//            //默认返回现有的navigation stack中的VC
//            if (self.backNavigationController == nil && self.navigationController != nil) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            else if (self.backNavigationController != nil){
//                [self.backNavigationController popViewControllerAnimated:YES];
//            }
//        }
//    }
//    else {
//        //默认返回现有的navigation stack中的VC
//        if (self.backNavigationController == nil && self.navigationController != nil) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else if (self.backNavigationController != nil){
//            [self.backNavigationController popViewControllerAnimated:YES];
//        }
//    }
//
//}
-(void) setupTitleBar {
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissController:)];
    
    UINavigationItem *titleBar = [[UINavigationItem alloc] initWithTitle:@""];
    titleBar.leftBarButtonItem = buttonDone;
    
    CGFloat width = self.view.frame.size.width;
    navigationBarModal = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    //navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    navigationBarModal.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    navigationBarModal.barStyle = barStyle;
    [navigationBarModal pushNavigationItem:titleBar animated:NO];
    
    [self.view addSubview:navigationBarModal];
}

-(void) setupToolBar {
    if (self.toolBar) {
        return;
    }
    float webViewHeight = self.view.height;
   
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, webViewHeight-kToolBarHeight, 320, kToolBarHeight)];
    [_toolBar setBackgroundColor:UIColorFromRGB(0xf5f5f5)];

//    [_toolBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _toolBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:self.toolBar];
    _buttonGoBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTouchUp:)];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 30;
    
    _buttonGoForward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonTouchUp:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicator.frame = CGRectMake(11, 7, 20, 20);
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 43, 33)];
    [containerView addSubview:_activityIndicator];
    UIBarButtonItem *buttonContainer = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    UIBarButtonItem *buttonReload = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reload_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadButtonTouchUp:)];


    [_toolBar setItems:@[_buttonGoBack,fixedSpace,_buttonGoForward,flexibleSpace,buttonContainer,buttonReload] animated:YES];
    
    
    _buttonGoBack.enabled = NO;
    _buttonGoForward.enabled = NO;

    
}
-(void) layoutWebView {
    float webViewHeight = self.view.height;
    if (_showToolBar) {
        webViewHeight -= kToolBarHeight;
    }

    self.webView.frame = CGRectMake(0, 0, getScreenFrame().size.width, webViewHeight);
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}


- (void) initWebView
{
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate =self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
//    if(self.navigationController){
//        if ([self.navigationController isKindOfClass:[BABasicNavigationController class]]) {
//            self.navigationBarHidden = self.shouldHiddenNavigationBar;
//        }else{
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//        }
//    }
//    UIImage *backgroundImage = [UIImage imageNamed:pBackArrowImageName_new];
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
//    [leftBtn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarBtn = barItem(leftBtn);
//    self.navigationItem.backBarButtonItem = nil;
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
    self.webView.scalesPageToFit = self.scalesPageToFit;
    if (self.navigationbarTitle) {
        [self setTitle:self.navigationbarTitle];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.webView];
    [self layoutWebView];
    if (_showToolBar) {
        [self setupToolBar];
    }
    
//    if([self isModal]){
//        [self setupTitleBar];
//    }
    
    //NSMutableURLRequest优先
//    if(isIOS7AndBeyond()){
//        [self loadBlankPage];
//        [self performSelector:@selector(loadPage) withObject:nil afterDelay:0.3];
//    }else{
//        [self loadPage];
//    }
    [self loadPage];
}
-(void)loadPage{
    if (_request) {
        _request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        [self.webView loadRequest:_request];
    }
    else {
        //WILLDO:更详细的支持协议
        if (![self.linkUrl hasPrefix:@"http://"] && ![self.linkUrl hasPrefix:@"https://"]) {
            self.linkUrl = [NSString stringWithFormat:@"http://%@",self.linkUrl];
        }
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions
//加载本地的一个空html页面，解决webview没有加载完网页，底部留下tabbar黑色区域的问题
- (void)loadBlankPage {
    if (!errorRequest) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"load_error" ofType:@"html"];
        NSURL *errorUrl = [NSURL fileURLWithPath:filePath];
        errorRequest = [NSURLRequest requestWithURL:errorUrl];
    }
    [self.webView loadRequest:errorRequest];
}

-(void) toggleBackForwardButtons {
    _buttonGoBack.enabled = _webView.canGoBack;
    _buttonGoForward.enabled = _webView.canGoForward;
}

- (void)backButtonTouchUp:(id)sender {
    [_webView goBack];
    [self toggleBackForwardButtons];
}

- (void)forwardButtonTouchUp:(id)sender {
    [_webView goForward];
    [self toggleBackForwardButtons];
}
- (void)reloadButtonTouchUp:(id)sender {
    [_webView reload];
    [self toggleBackForwardButtons];
}


-(void)showActivityIndicators {
    [_activityIndicator setHidden:NO];
    [_activityIndicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)hideActivityIndicators {
    [_activityIndicator setHidden:YES];
    [_activityIndicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self toggleBackForwardButtons];
    [self showActivityIndicators];
    
    if (self.showHUD && self.navigationType != UIWebViewNavigationTypeLinkClicked && [self.navigationUrl hasPrefix:@"http"])
    {
        [[[PAHUDService shared] blockHUD] showWithText:k_loading_HUD maskType:PAHUDMaskTypeBlack cancelable:YES];
    }
    
    if (!CGSizeEqualToSize(CGSizeZero, _contentSize)) {
        self.webView.scrollView.contentSize = _contentSize;
    }
    [_footerView removeFromSuperview];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    self.navigationType = navigationType;
    self.navigationUrl = request.URL.absoluteString;
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.showHUD)
    {
        [[[PAHUDService shared] blockHUD] dismiss];
    }
    
    if (!self.navigationbarTitle) {
        NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        
        if (pageTitle) {
            if (pageTitle.length>9) {
                pageTitle = [[pageTitle substringToIndex:8] stringByAppendingString:@"..."];
            }
        }
        [self setTitle:pageTitle];
    }
    [self humansetIndicators];
    [self hideActivityIndicators];
    [self toggleBackForwardButtons];
    
    _contentSize = self.webView.scrollView.contentSize;
    
    if (nil != _footerView) {
        _footerView.frame = CGRectMake(0, self.webView.scrollView.contentSize.height, CGRectGetWidth(self.webView.scrollView.frame), CGRectGetHeight(_footerView.frame));
        [self.webView.scrollView addSubview:_footerView];
        
        [self.webView.scrollView setContentSize:CGSizeMake(self.webView.scrollView.contentSize.width, self.webView.scrollView.contentSize.height+CGRectGetHeight(_footerView.frame))];
    }
}
-(void)humansetIndicators
{
    if (_handresetVerticalScroll) {
        _webView.scrollView.showsVerticalScrollIndicator = NO;
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.showHUD)
    {
        [[[PAHUDService shared] blockHUD] dismiss];
    }
    
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    [self hideActivityIndicators];

    // Show error alert
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"无法加载页面", nil) andMessage:error.localizedDescription];
    [alertView addButtonWithTitle:NSLocalizedString(@"确定", nil) type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        
    }];
	[alertView show];
}

////judge modal
//-(BOOL)isModal
//{
//    BOOL isModal = ((self.parentViewController && self.parentViewController.presentedViewController == self) ||
//                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
//                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.presentedViewController == self.navigationController) ||
//                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
//                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
//    
//    //iOS 5+
//    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
//        
//        isModal = ((self.presentingViewController && self.presentingViewController.presentedViewController == self) ||
//                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
//                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.presentedViewController == self.navigationController) ||
//                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
//                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
//        
//    }
//    
//    return isModal;
//    
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView stopLoading];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (self.showHUD)
    {
        [[[PAHUDService shared] blockHUD] dismiss];
    }
}


-(void)dismissController:(id)sender
{
    //WILLDO:add ensenssial logical,just avoid crash
}

@end
