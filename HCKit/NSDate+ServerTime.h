//
//  NSDate+ServerTime.h
//  PAQZZ
//
//  Created by Wesley Yang on 6/16/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ServerTime)


+(NSDate*)serverTime;


+(void)syncServerTimeWithYMDHMS:(NSString*)dateStr;
+(void)syncServerTimeTo:(NSDate*)newDate;

@end
