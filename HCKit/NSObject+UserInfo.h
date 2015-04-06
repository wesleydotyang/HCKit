//
//  NSObject+UserInfo.h
//  PAQZZ
//
//  Created by Chenny Shan on 12/26/13.
//  Copyright (c) 2013 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UserInfo)

- (void)addUserValue:(id)obj forKey:(id)key;
- (NSDictionary *)userInfo;
- (id)userValueForKey:(id)key;

- (BOOL)isAnyKindOfClasses:(NSArray *)classes;

@end
