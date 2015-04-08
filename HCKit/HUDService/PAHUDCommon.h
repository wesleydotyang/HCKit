//
//  PAHUDCommon.h
//  PAQZZ
//
//  Created by william mu on 14-5-16.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#ifndef PAQZZ_PAHUDCommon_h
#define PAQZZ_PAHUDCommon_h

typedef NS_ENUM (NSUInteger, PAHUDBlockType)
{
    PAHUDWalletLoading          = 1,
    PAHUDShieldLoading          = 2,
};

typedef NS_ENUM (NSUInteger, PAHUDCancelType)
{
    PAHUDActiveCancel          = 1,
    PAHUDPassiveCancel         = 2,
};

typedef NS_ENUM (NSUInteger, PAPromptHUDType)
{
    PAHUDPromptHUDSuccess       = 1,
    PAHUDPromptHUDError,
    PAHUDPromptHUDWarning
};

typedef NS_ENUM (NSUInteger, PAHUDMaskType)
{
    PAHUDMaskTypeNone       = 1,
    PAHUDMaskTypeBlack,
};

#endif
