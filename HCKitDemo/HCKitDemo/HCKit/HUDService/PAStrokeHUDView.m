//
//  PALoadingHUD.m
//  PAQZZ
//
//  Created by linsen on 14-5-14.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PAStrokeHUDView.h"
#import "PAPathView.h"
#import "HCUtilityMacro.h"
#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface PAStrokeHUDView()

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;
@property (nonatomic, assign, readonly) BOOL isShowing;
@property (nonatomic, strong, readonly) UIView *bgView;
@property (nonatomic, strong, readonly) PAPathView *pathWalletView;
@property (nonatomic, strong, readonly) PAPathView *pathShieldView;
@property (nonatomic, strong, readonly) UILabel *stringLabel;
@property (nonatomic, assign, readonly) BOOL cancelable;
@end

@implementation PAStrokeHUDView

@synthesize overlayWindow,isShowing;

#pragma mark - Show Methods

- (void)createWalletPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(12,90)];
    //左上圆角
    [path addLineToPoint:CGPointMake(12,36)];
    UIBezierPath *c0 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(36, 36) radius:24 startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
    [path appendPath:c0];
    [path addLineToPoint:CGPointMake(36,12)];
    //右上圆角
    [path addLineToPoint:CGPointMake(112,12)];
    UIBezierPath *c1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(112, 36) radius:24 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
    [path appendPath:c1];
    [path addLineToPoint:CGPointMake(136,36)];
    //右下圆角
    [path addLineToPoint:CGPointMake(136,92)];
    UIBezierPath *c2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(112, 92) radius:24 startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
    [path appendPath:c2];
    [path addLineToPoint:CGPointMake(112,116)];
    // 左下
    [path addLineToPoint:CGPointMake(54,116)];
    UIBezierPath *c3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(54, 110) radius:6 startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
    [path appendPath:c3];
    [path addLineToPoint:CGPointMake(48,104)];
    // 内圈左上
    [path addLineToPoint:CGPointMake(48,54)];
    UIBezierPath *c4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(54, 54) radius:6 startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
    [path appendPath:c4];
    [path addLineToPoint:CGPointMake(60,48)];
    // 内圈右上
    [path addLineToPoint:CGPointMake(94,48)];
    UIBezierPath *c5 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(94, 54) radius:6 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
    [path appendPath:c5];
    [path addLineToPoint:CGPointMake(100,60)];
    // 内圈右下
    [path addLineToPoint:CGPointMake(100,74)];
    UIBezierPath *c6 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(94, 74) radius:6 startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
    [path appendPath:c6];
    [path addLineToPoint:CGPointMake(88,80)];
    // 终点
    [path addLineToPoint:CGPointMake(58,82)];
    // 缩小
    [path applyTransform:CGAffineTransformMakeScale(.28, .28)];
    
    
    _pathWalletView = [[PAPathView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _pathWalletView.backgroundColor = [UIColor clearColor];
    _pathWalletView.center = CGPointMake(CGRectGetWidth(self.bounds)/2,CGRectGetHeight(self.bounds)/2 );
    _pathWalletView.pathLayer.lineWidth = 6.5;
    // 宽度不同为了掩盖色差
    _pathWalletView.bgPathLayer.lineWidth = 6.1;
    
    _pathWalletView.pathLayer.path = path.CGPath;
    _pathWalletView.pathLayer.strokeColor = UIColorFromRGB(0x8c8c8c).CGColor;
    
    CGPathRef btBgPath = CGPathCreateCopy(path.CGPath);
    _pathWalletView.bgPathLayer.path = btBgPath;
    CGPathRelease(btBgPath);
    _pathWalletView.bgPathLayer.strokeColor = UIColorFromRGB(0xffffff).CGColor;

}

- (void)createShieldPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(72,108)];
    [path addLineToPoint:CGPointMake(156,108)];
    [path addLineToPoint:CGPointMake(156,60)];
    // 内圈左上
    [path addLineToPoint:CGPointMake(60,60)];
    // 内圈左下
    [path addLineToPoint:CGPointMake(60,156)];
    [path addLineToPoint:CGPointMake(204,156)];
    // 外圈右上
    [path addLineToPoint:CGPointMake(204,12)];
    [path addLineToPoint:CGPointMake(12,12)];
    // 外圈左下
    [path addLineToPoint:CGPointMake(12,240)];
    // 外圈中下
    [path addLineToPoint:CGPointMake(108,310)];
    [path addLineToPoint:CGPointMake(210,240)];
    
    [path applyTransform:CGAffineTransformMakeScale(.13, .13)];
    
    _pathShieldView = [[PAPathView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    _pathShieldView.backgroundColor = [UIColor clearColor];
    _pathShieldView.center = CGPointMake(CGRectGetWidth(self.bounds)/2,CGRectGetHeight(self.bounds)/2 );
    _pathShieldView.pathLayer.lineWidth = 3.2;
    _pathShieldView.pathLayer.path = path.CGPath;
    _pathShieldView.pathLayer.strokeColor = UIColorFromRGB(0xffffff).CGColor;
}

- (void)createStringLabel{
    _stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)/2+20, CGRectGetWidth(self.bounds), 50)];
    [_stringLabel setTextAlignment:NSTextAlignmentCenter];
    [_stringLabel setBackgroundColor:[UIColor clearColor]];
    _stringLabel.font = [UIFont systemFontOfSize:15];
    _stringLabel.textColor =UIColorFromRGB(0xffffff);
    _stringLabel.text = @"正在加载...";
}

- (void)createBgView{
    _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.userInteractionEnabled = YES;
    _bgView.alpha = .5;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createWalletPath];
        [self createShieldPath];
        [self createStringLabel];
        [self createBgView];

        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        _cancelable = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)AppEnterForeground:(NSNotification*)notification
{
    if (_pathWalletView.superview) {
        [_pathWalletView animateDrawPathAndClosePathWithDuration:1.5 repeat:YES];
    }
    else if (_pathShieldView.superview){
        [_pathShieldView animateDrawPathWithDuration:1.2 repeat:YES];
    }
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate methods

-(void)handleSingleTap:(id)sender {
    if (_cancelable) {
        if ([self.delegate respondsToSelector:@selector(onCancel:)]) {
            [self.delegate performSelector:@selector(onCancel:) withObject:self];
        }
        [self dismiss];
        _cancelable = NO;
    }
}

#pragma mark - Getters

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = YES;
        overlayWindow.windowLevel = UIWindowLevelStatusBar;
    }
    return overlayWindow;
}

-(BOOL) isShowing {
    return isShowing ;
}

-(void) setIsShowing:(BOOL)value{
    isShowing = value ;
}

-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel HUDAnimation:(PAHUDBlockType)animation{
    
    if(!self.superview) {
        [self.overlayWindow addSubview:self];
    }
    _cancelable = cancel;
    isShowing = YES;
    [self.overlayWindow setHidden:NO];
    _stringLabel.text = msg;
    if (type == PAHUDMaskTypeNone) {
        self.bgView.alpha = 0;
    }
    else{
        self.bgView.alpha = 0.5;
    }
    [self addSubview:_bgView];
    [self addSubview:_stringLabel];
    
    if ( animation == PAHUDWalletLoading ) {
        [self addSubview:_pathWalletView];
        [_pathWalletView animateDrawPathAndClosePathWithDuration:1.5 repeat:YES];
    }
    else if (animation == PAHUDShieldLoading){
        [self addSubview:_pathShieldView];
        [_pathShieldView animateDrawPathWithDuration:1.2 repeat:YES];
    }
}

-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel
{
    [self showWithText:msg maskType:type cancelable:cancel HUDAnimation:PAHUDWalletLoading];
}

-(void) setText:(NSString*)msg
{
    _stringLabel.text = msg;
}

-(void) setText:(NSString*)msg cancelable:(BOOL) cancel
{
    [self setText:msg];
    _cancelable = cancel;
}

-(void) changeNewType:(PAHUDBlockType)animation
{
    if (isShowing) {
        [_pathWalletView removeFromSuperview];
        [_pathShieldView removeFromSuperview];
        
        if ( animation == PAHUDWalletLoading ) {
            [self addSubview:_pathWalletView];
            [_pathWalletView animateDrawPathAndClosePathWithDuration:1.5 repeat:YES];
        }
        else if (animation == PAHUDShieldLoading){
            [self addSubview:_pathShieldView];
            [_pathShieldView animateDrawPathWithDuration:1.2 repeat:YES];
        }
    }
}

-(void) dismiss
{
    isShowing = NO;
    [_pathWalletView.pathLayer removeAllAnimations];
    [_bgView removeFromSuperview];
    [_pathWalletView removeFromSuperview];
    [_pathShieldView removeFromSuperview];
    [_stringLabel removeFromSuperview];
    [overlayWindow removeFromSuperview];
    overlayWindow = nil;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
