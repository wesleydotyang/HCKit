//
//  PAUserDiskCache.m
//  PAQZZ
//
//  Created by Wesley Yang on 3/27/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import "PAUserDiskCache.h"
#import "HCUtilityMacro.h"

@implementation PAUserDiskCache


-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+(instancetype)shared
{
    DebugAssert(0, @"禁止调用父类shared方法,使用diskCacheWithUserID");
    return nil;
}


+(PAUserDiskCache *)diskCacheWithUserID:(NSString *)userID
{
    static dispatch_once_t onceToken;
    static NSMutableArray *__userCaches;
    dispatch_once(&onceToken, ^{
        __userCaches = [[NSMutableArray alloc] init];
    });
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"DiskCache%@",userID]];
    for (PAUserDiskCache *cache in __userCaches) {
        if ([cache.filePath isEqualToString:path]) {
            return cache;
        }
    }
    PAUserDiskCache *cache = [[PAUserDiskCache alloc] init];
    [__userCaches addObject:cache];
    cache.filePath = path;
    return cache;
}


@end
