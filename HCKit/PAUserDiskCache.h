//
//  PAUserDiskCache.h
//  PAQZZ
//
//  Created by Wesley Yang on 3/27/14.
//  Copyright (c) 2014 平安付. All rights reserved.
//

#import "HCDiskCache.h"


#define kCACHE_BP_PUSH_MESSAGE_ENABLED  @"kCACHE_BP_PUSH_MESSAGE_ENABLED"


@interface PAUserDiskCache : HCDiskCache


+(PAUserDiskCache*)diskCacheWithUserID:(NSString*)userID;

@end
