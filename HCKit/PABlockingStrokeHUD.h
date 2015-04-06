//
//  PAStrokeHUD.h
//  PAQZZ
//
//  Created by linsen on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PABlockingHUD.h"

@interface PABlockingStrokeHUD : PABlockingHUD

+(instancetype) shared;

-(void) showWithText:(NSString*)msg;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel;
-(void) showWithText:(NSString*)msg maskType:(PAHUDMaskType)type cancelable:(BOOL) cancel HUDAnimation:(PAHUDBlockType)animation;
-(void) setText:(NSString*)msg;
-(void) dismiss;
-(BOOL) isShowing;
@end
