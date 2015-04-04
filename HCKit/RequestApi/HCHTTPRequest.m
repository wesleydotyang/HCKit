//
//  HCHTTPRequest.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-16.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCHTTPRequest.h"
#import "NSObject+UserInfo.h"
#define kBaseHTTPURL @" sds"

NSString * const kInfoKeyHTTPCookie = @"InfoKey_HTTPCookie";
NSString * const kInfoKeyResponseObject = @"InfoKey_ResponseObject";
NSUInteger const kHTTPErrorParseFailed = 101;
NSInteger const kHTTPResultCodeLogicSucceed = 200;

@interface HCHTTPRequest()
@property (nonatomic, strong) NSOperation *httpOperation;

@end


@implementation HCHTTPRequest

+ (AFHTTPRequestOperationManager *)sharedRequestOperationManager
{
    static dispatch_once_t once;
    static AFHTTPRequestOperationManager *RequestOperationManager;
    dispatch_once(&once, ^ {
        NSURL *url = [NSURL URLWithString:kBaseHTTPURL];
        RequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        RequestOperationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        RequestOperationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:0];
        RequestOperationManager.securityPolicy.allowInvalidCertificates = YES;
        RequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
//RequestOperationManager.requestSerializer.acceptableContentTypes
    });
    return RequestOperationManager;
}

//- (instancetype)initWithAPI:(HCRequestBaseApi *)api method:(HCHttpMethod)method{
//    self = [self initWithAPI:api];
//    self.method = method;
//    return self;
//}

-(NSString *)uuid{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    NSString *value = (__bridge_transfer NSString *)uuidString;
    return value;
}

- (instancetype)initWithAPI:(HCRequestBaseApi *)api
{
    if (self = [super init]) {
        _api = api;
        _identifier = [[self uuid] copy];
    }
    return self;
}

+ (instancetype)requestWithAPI:(HCRequestBaseApi *)api delegate:(id<AsyncDelegate>)delegate
{
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.delegate = delegate;
    return request;
}
- (void)start
{
    [super start];
    //    NSLog(@"request operation: %@, params: %@", _api.operation, _api.parameters);
    //    __weak __typeof(self)weakSelf = self;
    
    //    RAC(self, inProgress) = [RACSignal combineLatest:@[
    //                                                       RACObserve(self, httpOperation),
    //                                                       RACObserve(self.httpOperation, isFinished),
    //                                                       RACObserve(self.httpOperation, isCancelled)
    //                                                       ]
    //                                              reduce:^id(AFHTTPRequestOperation *operation,
    //                                                         NSNumber *isFinished,
    //                                                         NSNumber *isCancelled){
    //                                                  return @((nil != operation) && !isFinished.boolValue && !isCancelled.boolValue);
    //                                              }];
    
    // for AFHTTP 2.x
//    NSString *method;
//    switch (self.method) {
//        case HCHttpMethod_GET:
//            method = @"GET";
//            break;
//        case HCHttpMethod_POST:
//            method = @"POST";
//            break;
//        default:
//            break;
//    }
    
     AFHTTPRequestOperationManager *manager = [HCHTTPRequest sharedRequestOperationManager];
     NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:_api.httpMethod
     URLString:[[NSURL URLWithString:_api.operation relativeToURL:manager.baseURL] absoluteString]
     parameters:_api.parameters
     error:nil];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
     [self performSuccessfulCallback:operation response:responseObject];
     
     self.httpOperation = nil;
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     if (NSURLErrorCancelled != error.code) {
     [self performFailedCallback:operation error:error];
     }
     
     self.httpOperation = nil;
     }];
     operation.completionQueue = self.callbackQueue;
     [manager.operationQueue addOperation:operation];
     self.httpOperation = operation;
}


- (void)performSuccessfulCallback:(AFHTTPRequestOperation *)operation response:(id)responseObject
{
    NSLog(@"api:%@, responseString: %@", _api.operation, operation.responseString);
    self.inProgress = NO;
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSInteger errorCode = [responseObject[@"ret"] integerValue];
        if (kHTTPResultCodeLogicSucceed == errorCode) {
            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[operation.response allHeaderFields] forURL:operation.response.URL];
            if (nil != cookies) {
                [self addUserValue:cookies forKey:kInfoKeyHTTPCookie];
            }
            
            id wrappedObject = [_api responseObjectFromDict:responseObject];
            
            
            if ([_delegate respondsToSelector:@selector(asyncer:didFinishWithResult:)]) {
                [_delegate performSelector:@selector(asyncer:didFinishWithResult:) withObject:self withObject:wrappedObject];
            }
        }
        else {
            NSString *resultMessage = responseObject[@"message"];
            NSError *error = [NSError errorWithDomain:@"PAHTTPRequest" code:errorCode userInfo:
                              @{NSLocalizedDescriptionKey : @"Result code is not 200",
                                NSLocalizedFailureReasonErrorKey : ([resultMessage isKindOfClass:[NSString class]] && resultMessage.length > 0 ? resultMessage : @"系统错误，请稍后重试"),
                                kInfoKeyResponseObject : responseObject}];
            
            [self performFinalErrorCallback:error];

        }
    }
    else {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Json parsed result is not a dictionary: %@", NSStringFromClass([responseObject class])], NSLocalizedDescriptionKey, @"服务器返回数据异常，请稍后重试", NSLocalizedFailureReasonErrorKey, nil];
        if (nil != responseObject) {
            userInfo[kInfoKeyResponseObject] = responseObject;
        }
        NSError *error = [NSError errorWithDomain:@"PAHTTPRequest" code:kHTTPErrorParseFailed userInfo:userInfo];
        [self performFinalErrorCallback:error];
    }
}

- (void)performFailedCallback:(AFHTTPRequestOperation *)operation error:(NSError *)error
{
    NSLog(@"api:%@, responseString: %@", _api.operation, operation.responseString);
    self.inProgress = NO;
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
    userInfo[NSLocalizedFailureReasonErrorKey] = @"哎呦，网络不太好";
    NSError *newError = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
    [self performFinalErrorCallback:newError];
}

- (void)performFinalErrorCallback:(NSError *)error
{
    NSLog(@"HTTP error:[%ld] %@",(long)error.code, [error localizedFailureReason]);
    NSLog(@"%@",error);
    
    if ([_delegate respondsToSelector:@selector(asyncer:didFailWithError:)]) {
        [_delegate performSelector:@selector(asyncer:didFailWithError:) withObject:self withObject:error];
    }
}


- (void)cancel
{
    [super cancel];
    dispatch_async(self.callbackQueue, ^{
        [_httpOperation cancel];
        self.httpOperation = nil;
        self.delegate = nil;
    });
}

- (void)dealloc
{
    [_httpOperation cancel];
    self.httpOperation = nil;
    self.delegate = nil;
    NSLog(@"PAHTTPRequest dealloc: %p", self);
}



@end
