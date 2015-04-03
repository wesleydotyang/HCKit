//
//  HCUtilityMacro.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#ifndef BusinessArea_HCUtilityMacro_h
#define BusinessArea_HCUtilityMacro_h

#if ! __has_feature(objc_arc)

#define CEAutorelease(__v) ([__v autorelease])
#define CEReturnAutoreleased CEAutorelease

#define CERetain(__v) ([__v retain])
#define CEReturnRetained CERetain

#define CERelease(__v) ([__v release])

#else
// -fobjc-arc
#define CEAutorelease(__v) do {} while (0)
#define CEReturnAutoreleased(__v) (__v)

#define CERetain(__v) do {} while (0)
#define CEReturnRetained(__v) (__v)

#define CERelease(__v) do {} while (0)

#endif

#ifdef DEBUG
#define DebugAssert(cnd, prompt)  NSAssert((cnd), (prompt))
#else
#define DebugAssert(cnd, prompt)
#endif


#pragma mark 制造颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif
