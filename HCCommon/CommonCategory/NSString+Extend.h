//
//  NSString+Extend.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-17.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
//检测字符串是否为空|null|nil
#define IsEmptyString(a) (a==nil || [a isKindOfClass:[NSNull class]] || a.length==0)
//字符串是否一样，“”=nil=null
#define IsSameString(a,b) ( (IsEmptyString(a)&&IsEmptyString(b)) || [a isEqualToString:b] )
//返回第一个非空string,全空返回@""
#define FirstNonEmptyString(a,b)        (IsEmptyString(a)?(IsEmptyString(b)?@"":b):a)
#define FirstNonEmptyString3(a,b,c)     FirstNonEmptyString(FirstNonEmptyString(a,b),c)
#define FirstNonEmptyString4(a,b,c,d)   FirstNonEmptyString(FirstNonEmptyString3(a,b,c),d)

@interface NSString (Extend)
- (NSString *)md5;

- (NSDate *)dateFromFormat:(NSString *)aformat timeZone:(NSTimeZone *)zone;

+ (NSString *)uuid;

@end
