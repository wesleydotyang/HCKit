//
//  PALoadingHUD.h
//  PAQZZ
//
//  Created by linsen on 14-5-14.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAHUDCommon.h"


@protocol PAStrokeHUDViewDelegate;

@interface PAStrokeHUDView : UIView

@property (nonatomic, weak) id<PAStrokeHUDViewDelegate> delegate;

-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel HUDAnimation:(PAHUDBlockType)animation;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel;
-(void) setText:(NSString*)msg;
-(void) setText:(NSString*)msg cancelable:(BOOL) cancel;
-(void) changeNewType:(PAHUDBlockType)animation;
-(void) dismiss;
-(BOOL) isShowing;

@end


@protocol PAStrokeHUDViewDelegate <NSObject>
@optional
-(void) onCancel:(PAStrokeHUDView*) hud;
@end