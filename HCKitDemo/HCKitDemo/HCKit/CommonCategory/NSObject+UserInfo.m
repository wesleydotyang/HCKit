//
//  NSObject+UserInfo.m
//  PAQZZ
//
//  Created by Chenny Shan on 12/26/13.
//  Copyright (c) 2013 平安付. All rights reserved.
//

#import "NSObject+UserInfo.h"
#import <objc/runtime.h>

static int kUserInfoKey;

@implementation NSObject (UserInfo)

- (void)addUserValue:(id)obj forKey:(id)key
{
    if(nil != key && nil != obj) {
        NSMutableDictionary *userInfo = objc_getAssociatedObject(self, &kUserInfoKey);
        if (userInfo == nil) {
            userInfo = [[NSMutableDictionary alloc] init];
        }
        [userInfo setObject:obj forKey:key];
        
        objc_setAssociatedObject(self, &kUserInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN);
    }
}

- (NSDictionary *)userInfo
{
    NSDictionary *dict = nil;
    NSMutableDictionary *userInfo = objc_getAssociatedObject(self, &kUserInfoKey);
    if (userInfo.count > 0) {
        dict = [NSDictionary dictionaryWithDictionary:userInfo];
    }
    return dict;
}

- (id)userValueForKey:(id)key
{
    NSMutableDictionary *userInfo = objc_getAssociatedObject(self, &kUserInfoKey);
    return [userInfo objectForKey:key];
}

- (BOOL)isAnyKindOfClasses:(NSArray *)classes
{
    return YES;
}

@end
