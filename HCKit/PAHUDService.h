//
//  PAHUDService.h
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PABlockingHUD.h"
#import "PAPromptHUD.h"

@interface PAHUDService : NSObject
+(instancetype) shared;
-(PABlockingHUD*) blockHUD;
-(PAPromptHUD*) promptHUD;
@end
