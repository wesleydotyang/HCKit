//
//  NSDate+Extension.m
//
//  Created by Chenny Shan on 11-4-17.
//  Copyright 2011 SNDA. All rights reserved.
//

#import "NSDate+Extend.h"

NSString * const kDateFormatyyyyMMddHHmmss = @"yyyy-MM-dd HH:mm:ss";
NSString * const kDateFormatyyyyMMddHHmm = @"yyyy-MM-dd HH:mm";

@implementation NSDate (NSDateExtension)

+ (NSTimeZone *)UTCTimeZone
{
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return utcTimeZone;
}

/*
 timeZone names: NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
 e.g. "Asia/Shanghai", "Asia/Singapore"
 */
+ (NSTimeZone *)UTCPlus8TimeZone
{
    return [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
}

- (NSString *)stringFromFormat:(NSString *)aformat timeZone:(NSTimeZone *)zone
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (nil != zone) {
        [formatter setTimeZone:zone];
    }
	[formatter setDateFormat:aformat];
	NSString *text = [formatter stringFromDate:self];
	return text;
}


//month个月后的日期
- (NSDate *)dateafterMonth:(int)month

{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    
    [componentsToAdd setMonth:month];
    //-----
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setMonth:2];
//    [comps setDay:3];
//    NSDate *date = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    //----
    
    [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    
    
    
    return dateAfterMonth;
    
}


@end
