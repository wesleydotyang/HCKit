//
//  PAPromptHUD.h
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PAHUD.h"
#import "PAHUDCommon.h"
#import "PAPromptHUDDelegate.h"
#import "HCKit.h"
// reserved class
@interface PAPromptHUD : PAHUD
@property (nonatomic, weak) id<PAPromptHUDDelegate> delegate;
-(void) showWithText:(NSString *)msg type:(PAPromptHUDType)hudType;
-(void) setText:(NSString*)msg;
-(void) showImage:(UIImage*)image status:(NSString*)msg;
-(void) showImage:(UIImage*)image status:(NSString*)status duration:(NSTimeInterval)duration;
-(BOOL) isShowing;
-(void) dismiss;
@end
