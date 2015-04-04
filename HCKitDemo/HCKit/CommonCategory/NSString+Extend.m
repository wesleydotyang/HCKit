//
//  NSString+Extend.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-17.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extend)
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (NSDate *)dateFromFormat:(NSString *)aformat timeZone:(NSTimeZone *)zone
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:aformat];
    if (nil != zone) {
        [formatter setTimeZone:zone];
    }
	NSDate *date = [formatter dateFromString:self];
	return date;
}
+ (NSString *)uuid
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
	CFStringRef uuidString = CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    NSString *value = (__bridge_transfer NSString *)uuidString;
    return value;
}

@end
