//
//  HCProfileService.m
//  PAQZZ
//
//  Created by 花晨 on 14-6-5.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import "HCProfileService.h"
#define DefaultUpdateTime 60*60
#import "extobjc.h"
@interface HCProfileService()
@end

@implementation HCProfileService
+(instancetype)profileServiceWithUrl:(NSString *)urlString delegate:(id)delegate{
    HCProfileService *service = [[HCProfileService alloc] init];
    service.urlString = urlString;
    service.delegate = delegate;
    [service downLoadDataWithUrl:urlString];
    return service;
}
-(id)init{
    self = [super init];
    if (self) {
        self.downLoadState =  ProfileServiceDownLoadState_unStart;
        self.autoRefreshEnable = YES;
        self.downLoadFailRetry = YES;
    }
    return self;
}

-(void)downLoadDataWithUrl:(NSString *)urlString{
    if (self.delegate) {
        [self.delegate  ProfileServiceDownStart:self];
    }
    self.downLoadState =  ProfileServiceDownLoadState_downLoading;
    NSURL *versionUrlString = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:versionUrlString cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    @weakify(self);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        @strongify(self);
        if (data) {
            NSError *error=nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            self.jsonData = json;
            self.downLoadState =  ProfileServiceDownLoadState_success;
            if (self.autoRefreshEnable) {
                [self autoRefresh];
            }
            if (self.delegate) {
                [self.delegate  ProfileService:self jsonResult:json];
            }
        }
        else{
            self.downLoadState =  ProfileServiceDownLoadState_fail;
            if (self.downLoadFailRetry) {
                [self downLoadDataWithUrl:self.urlString];
            }
            if (self.delegate) {
                [self.delegate  ProfileService:self downLoadError:connectionError];
            }
        }
    }];
}


-(void)autoRefresh{
    NSInteger updateTime = self.updateTime == 0?DefaultUpdateTime:self.updateTime;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(updateTime * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (self) {
            [self downLoadDataWithUrl:self.urlString];
        }
    });

}
@end
