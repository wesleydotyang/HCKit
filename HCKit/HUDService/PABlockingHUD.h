//
//  PABlockingHUD.h
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PABlockingHUDDelegate.h"


@interface PABlockingHUD : NSObject

// 外部设置delegate响应onShowHud，onDismissHud，onCancelHud，由于HUD是单件，使用完要将delegate置空
@property (nonatomic, weak) id<PABlockingHUDDelegate> delegate;

-(void) showWithText:(NSString*)msg;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel HUDAnimation:(PAHUDBlockType)animation;
-(void) setText:(NSString*)msg;
-(void) dismiss;
-(BOOL) isShowing;
@end
