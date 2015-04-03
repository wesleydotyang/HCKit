//
//  HCKit.h
//  HCKitDemo
//
//  Created by 花晨 on 15/4/3.
//  Copyright (c) 2015年 花晨. All rights reserved.
//

#import "HCUtilityMacro.h"
#import <UIKit/UIKit.h>
#import "HCUtilityFuc.h"
#ifndef HCKitDemo_HCKit_h
#define HCKitDemo_HCKit_h


#define PADBQuickCheck(SomeBool)            \
{                                           \
if (!(SomeBool)) {                      \
DebugAssert(NO, @"Sql Failure");    \
}                                       \
}

#ifdef DEBUG
#define DebugAssert(cnd, prompt)  NSAssert((cnd), (prompt))
#else
#define DebugAssert(cnd, prompt)
#endif

#define PADBQuickCheck(SomeBool)            \
{                                           \
if (!(SomeBool)) {                      \
DebugAssert(NO, @"Sql Failure");    \
}                                       \
}

#define PADBTransactionSQLCheck(SomeBool, rollBack)             \
{                                                               \
if (!(SomeBool)) {                                          \
DebugAssert(NO, @"Sql Failuer in Transaction");         \
if (rollBack != nil)                                    \
*(rollBack) = YES;                                  \
return;                                                 \
}                                                           \
}


#endif
