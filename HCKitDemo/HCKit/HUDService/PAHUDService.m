//
//  PAHUDService.m
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "PAHUDService.h"
#import "PASVPromptHUD.h"
#import "PABlockingStrokeHUD.h"

@interface PAHUDService()
@property (nonatomic, readonly) Class promptHUDClass;
@property (nonatomic, readonly) Class blockingHUDClass;
@end

@implementation PAHUDService

+(instancetype) shared{
    static dispatch_once_t once;
    static PAHUDService *shared;
    dispatch_once(&once, ^ { shared = [PAHUDService new];});
    return shared;
}

-(Class) promptHUDClass
{
    return [PASVPromptHUD class];
}

-(Class) blockingHUDClass
{
    return [PABlockingStrokeHUD class];
}

-(PABlockingHUD*) blockHUD
{
    return [self.blockingHUDClass shared];
}

-(PAPromptHUD*) promptHUD
{
    return [self.promptHUDClass shared];
}

@end
