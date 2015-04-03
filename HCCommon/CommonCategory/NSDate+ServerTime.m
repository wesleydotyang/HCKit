//
//  NSDate+ServerTime.m
//  PAQZZ
//
//  Created by Wesley Yang on 6/16/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import "NSDate+ServerTime.h"


static NSTimeInterval   _ServerTimeIntervalToSysRunTime = 0;

@implementation NSDate (ServerTime)


+(NSDate *)serverTime{
    int sys = CACurrentMediaTime();
    int server = sys + _ServerTimeIntervalToSysRunTime;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:server];
    return date;
}

+(void)syncServerTimeWithYMDHMS:(NSString *)dateStr
{
    if (IsEmptyString(dateStr)) {
        return;
    }
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyyMMddHHmmss";
    [self syncServerTimeTo:[f dateFromString:dateStr]];
}

+(void)syncServerTimeTo:(NSDate *)newDate
{
    if (newDate) {
        NSLog(@"sync time to %@",newDate);
        double seconds = [newDate timeIntervalSinceReferenceDate];
        double sys = CACurrentMediaTime();
        _ServerTimeIntervalToSysRunTime = seconds - sys;
    }
}

+(void)load
{
    double seconds = [NSDate timeIntervalSinceReferenceDate];
    double sys = CACurrentMediaTime();
    _ServerTimeIntervalToSysRunTime = seconds - sys;
}


@end

