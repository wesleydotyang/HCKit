//
//  HCBasicAsyncer.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-16.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCRequestBaseApi.h"
#import "Asyncing.h"
extern NSString * const kKeyExecutedError;
extern NSString * const kKeyExecutedExpectedResult;

@interface HCBasicAsyncer : NSObject<Asyncing,AsyncDelegate>{
    id<AsyncDelegate> __strong _delegate;
    BOOL _inProgress;
}

@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) BOOL inProgress;

/**
 The dispatch queue for `callbackBlock`. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, assign) dispatch_queue_t callbackQueue;

@property (nonatomic, strong) id<AsyncDelegate> delegate;   // strong here, avoiding its potential releasing before successful/failed callback completes

- (instancetype)init;
- (instancetype)initWithDelegate:(id<AsyncDelegate>)delegate;
- (instancetype)initWithDelegate:(id<AsyncDelegate>)delegate tag:(NSUInteger)tag;


@end
