//
//  NSDate+Extension.h
//
//  Created by Chenny Shan on 11-4-17.
//  Copyright 2011 SNDA. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDateFormatyyyyMMddHHmmss;
extern NSString * const kDateFormatyyyyMMddHHmm;

@interface NSDate (NSDateExtension)

+ (NSTimeZone *)UTCTimeZone;

+ (NSTimeZone *)UTCPlus8TimeZone;

/*
 #define kDateFormatyyyyMMdd @"yyyy-MM-dd"
 #define kDateFormatyyyyMMddHHmmss @"yyyy-MM-dd HH:mm:ss"
 #define kDateFormatyyyyMMddHHmmssSSS @"yyyy-MM-dd HH:mm:ss.SSS"
 */
- (NSString *)stringFromFormat:(NSString *)aformat timeZone:(NSTimeZone *)zone;

//month个月后的日期
- (NSDate *)dateafterMonth:(int)month;

@end
