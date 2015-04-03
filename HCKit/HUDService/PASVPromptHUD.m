//
//  PASVPromptHUD.m
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PASVPromptHUD.h"

@implementation PASVPromptHUD

+(instancetype) shared{
    static dispatch_once_t once;
    static PASVPromptHUD *shared;
    dispatch_once(&once, ^ { shared = [PASVPromptHUD new];});
    return shared;
}

-(void) showWithText:(NSString *)msg type:(PAPromptHUDType)hudType
{
    if(hudType == PAHUDPromptHUDSuccess)
    {
        [SVProgressHUD showSuccessWithStatus:msg];
    }
    else if(hudType == PAHUDPromptHUDError)
    {
        [SVProgressHUD showErrorWithStatus:msg];
    }
    else if(hudType == PAHUDPromptHUDWarning)
    {
        [SVProgressHUD showErrorWithStatus:msg];
    }
    else
    {
        DebugAssert(NO, @"Unsupported hud type");
    }
}

-(void) setText:(NSString*)msg
{
    [SVProgressHUD setStatus:msg];
}

-(void) showImage:(UIImage*)image status:(NSString*)msg
{
    [SVProgressHUD showImage:image status:msg];
}

-(void) showImage:(UIImage*)image status:(NSString*)status duration:(NSTimeInterval)duration
{
    [[SVProgressHUD sharedView] showImage:image status:status duration:duration];
}

-(BOOL) isShowing
{
    return [SVProgressHUD isVisible];
}

-(void) dismiss
{
    [SVProgressHUD dismiss];
}

@end
