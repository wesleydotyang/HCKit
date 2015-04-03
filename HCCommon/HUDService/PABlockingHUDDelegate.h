//
//  PABlockingHUDDelegate.h
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAHUDCommon.h"
@class PABlockingHUD;

@protocol PABlockingHUDDelegate <NSObject>
@optional
-(void) onShowHud:(PABlockingHUD*) hud;
-(void) onDismissHud:(PABlockingHUD*) hud;
-(void) onCancelHud:(PABlockingHUD*) hud cancelType:(PAHUDCancelType*) cancelType;
@end
