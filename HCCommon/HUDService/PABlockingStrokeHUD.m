//
//  PAStrokeHUD.m
//  PAQZZ
//
//  Created by linsen on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PABlockingStrokeHUD.h"
#import "PAStrokeHUDView.h"

static NSInteger showCount = 0;

@interface PABlockingStrokeHUD()<PAStrokeHUDViewDelegate>
@property (nonatomic,strong,readonly) PAStrokeHUDView *hud;
@property (nonatomic, assign) BOOL hudPoped;
@property (nonatomic, assign) PAHUDBlockType missedHUDAnimationType;
@property (nonatomic, assign) PAHUDBlockType showingHUDAnimationType;
@property (nonatomic, assign) BOOL missedCancelable;
@property (nonatomic, copy) NSString *missedMsg;
@property (nonatomic, assign) PAHUDMaskType missedMaskType;

@end

@implementation PABlockingStrokeHUD

+(instancetype) shared{
    static dispatch_once_t once;
    static PABlockingStrokeHUD *shared;
    dispatch_once(&once, ^ { shared = [PABlockingStrokeHUD new];});
    return shared;
}

-(id) init
{
    if (self = [super init]) {
        _hud = [[PAStrokeHUDView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _hud.delegate = self;
        _hudPoped = NO;
    }
    
    return self;
}

-(void) showWithText:(NSString*)msg
{
    [self showWithText:msg maskType:PAHUDMaskTypeBlack cancelable:NO HUDAnimation:PAHUDWalletLoading];
}

-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type
{
    [self showWithText:msg maskType:type cancelable:NO HUDAnimation:PAHUDWalletLoading];
}

-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel
{
    [self showWithText:msg maskType:type cancelable:cancel HUDAnimation:PAHUDWalletLoading];
}

-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel HUDAnimation:(PAHUDBlockType)animation{
    DebugAssert([NSThread isMainThread], @"not on main thread");
     _hudPoped = YES;
    NSLog(@"Strock HUD need to show,showCount = %d",showCount);
    if (![_hud isShowing]) {
        [_hud showWithText:msg maskType:type cancelable:cancel HUDAnimation:animation];
        _showingHUDAnimationType = animation;
    }
    else{
        [_hud setText:msg cancelable:cancel];
       
        _missedCancelable = cancel;
        _missedMaskType = type;
        _missedHUDAnimationType = animation;
    }
    [self onShow];
}

-(void) setText:(NSString*)msg
{
    DebugAssert([NSThread isMainThread], @"not on main thread");
    [_hud setText:msg];
}

-(void) dismiss
{
    DebugAssert([NSThread isMainThread], @"not on main thread");

    NSLog(@"Strock HUD need to dismiss ,showCount = %d",showCount);

    // 在leftSeconds秒后，没有被调用showWithText的情况下（_hudPoped为YES说明这段时间又有showWithText）才真正dismiss。
    _hudPoped = NO;
    double leftSeconds = 0.2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(leftSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_hudPoped == NO) {
            NSLog(@"Strock HUD really dismiss = %d",showCount);
            [_hud dismiss];
        }
        else{
            if (_showingHUDAnimationType!=_missedHUDAnimationType) {
                [_hud changeNewType:_missedHUDAnimationType];
            }
        }
    });

    [self onDismiss];
}

-(BOOL) isShowing
{
    return [_hud isShowing];
}


-(void) onCancel:(PAStrokeHUDView*) hud
{
    //showCount = 0;
    if ([self.delegate respondsToSelector:@selector(onCancelHud:cancelType:)]) {
        [self.delegate performSelector:@selector(onCancelHud:cancelType:) withObject:self withObject:@(PAHUDActiveCancel)];
    }
}

-(void) onShow
{
    if ([self.delegate respondsToSelector:@selector(onShowHud:)]) {
        [self.delegate performSelector:@selector(onShowHud:) withObject:self];
    }
}

-(void) onDismiss
{
    if ([self.delegate respondsToSelector:@selector(onDismissHud:)]) {
        [self.delegate performSelector:@selector(onDismissHud:) withObject:self];
    }
}

@end
