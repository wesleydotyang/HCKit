//
//  PASVPromptHUD.h
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PAPromptHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD(SVProgressHUDAdditions)

- (void)showImage:(UIImage*)image
           status:(NSString*)status
         duration:(NSTimeInterval)duration;
+ (SVProgressHUD*)sharedView;

@end

@interface PASVPromptHUD : PAPromptHUD

+(instancetype) shared;

-(void) showWithText:(NSString *)msg type:(PAPromptHUDType)hudType;
-(void) setText:(NSString*)msg;
-(void) showImage:(UIImage*)image status:(NSString*)msg;
-(void) showImage:(UIImage*)image status:(NSString*)status duration:(NSTimeInterval)duration;
-(BOOL) isShowing;
-(void) dismiss;
@end
