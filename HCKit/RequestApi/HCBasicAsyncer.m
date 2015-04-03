//
//  HCBasicAsyncer.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-16.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCBasicAsyncer.h"
NSString * const kKeyExecutedError = @"KeyExecutedError";
NSString * const kKeyExecutedExpectedResult = @"KeyExecutedExpectedResult";

@implementation HCBasicAsyncer
- (instancetype)init
{
    return [self initWithDelegate:nil tag:0];
}

- (instancetype)initWithDelegate:(id<AsyncDelegate>)delegate
{
    return [self initWithDelegate:delegate tag:0];
}

// destination initializer
- (instancetype)initWithDelegate:(id<AsyncDelegate>)delegate tag:(NSUInteger)tag
{
    if (self = [super init]) {
        _delegate = delegate;
        _tag = tag;
    }
    return self;
}

- (void)start
{
    //    NSAssert([NSThread isMainThread], @"Please invoke this on main thread!");
    if (nil == self.callbackQueue) {
        self.callbackQueue = dispatch_get_main_queue();
    }
    
    self.inProgress = YES;
    
    dispatch_async(self.callbackQueue, ^{
        if ([_delegate respondsToSelector:@selector(asyncerDidStart:)]) {
            [_delegate performSelector:@selector(asyncerDidStart:) withObject:self];
        }
        
    });
}

- (void)cancel
{
    //    NSAssert([NSThread isMainThread], @"Please invoke this on main thread!");
    //    _inProgress = NO;
    self.inProgress = NO;
}

- (void)setCallbackQueue:(dispatch_queue_t)aQueue
{
    if (_callbackQueue != aQueue) {
        if (NULL != _callbackQueue) {
#if !OS_OBJECT_USE_OBJC
            dispatch_release(_callbackQueue);
#endif
            _callbackQueue = NULL;
        }
        if (aQueue) {
#if !OS_OBJECT_USE_OBJC
            dispatch_retain(aQueue);
#endif
            _callbackQueue = aQueue;
        }
    }
}

- (id)copyWithZone:(NSZone *)zone
{
	return CEReturnRetained(self);
}

- (void)dealloc
{
    if (NULL != _callbackQueue) {
#if !OS_OBJECT_USE_OBJC
        dispatch_release(_callbackQueue);
#endif
        _callbackQueue = NULL;
    }
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

@end
