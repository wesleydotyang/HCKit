//
//  HCHTTPRequest.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-16.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCBasicAsyncer.h"
#import "AFHTTPRequestOperationManager.h"
extern NSString * const kInfoKeyHTTPCookie;
extern NSString * const kInfoKeyResponseObject;
extern NSUInteger const kHTTPErrorParseFailed;
extern NSInteger const kHTTPResultCodeLogicSucceed;

//typedef NS_ENUM(NSInteger, HCHttpMethod){
//    HCHttpMethod_POST,
//    HCHttpMethod_GET
//};


@interface HCHTTPRequest : HCBasicAsyncer<Asyncing>
{
    HCRequestBaseApi *_api;
}

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) HCRequestBaseApi *api;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) NSURLRequestCachePolicy policy;
//@property (nonatomic, assign) HCHttpMethod method;

- (instancetype)initWithAPI:(HCRequestBaseApi *)api;
//- (instancetype)initWithAPI:(HCRequestBaseApi *)api method:(HCHttpMethod)method;

+ (instancetype)requestWithAPI:(HCRequestBaseApi *)api delegate:(id<AsyncDelegate>)delegate;

@end
