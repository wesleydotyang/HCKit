//
//  HCRequestBaseApi.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-16.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCRequestBaseApi.h"

@implementation HCRequestBaseApi

-(NSDictionary *)baseParams{
    NSAssert(NO, @"Let subclasses implement");
    return nil;
}


-(NSMutableDictionary *)parameters{
    if (!_parameters) {
        if ([self baseParams]) {
            _parameters = [[NSMutableDictionary alloc] initWithDictionary:[self baseParams]];
        }else{
            _parameters = [[NSMutableDictionary alloc] init ];
        }
    }
    return _parameters;
}

-(void)additionalParams:(NSDictionary *)addParams{
    [self.parameters addEntriesFromDictionary:addParams];
}

//-(id)initWithAdditionalParams:(NSDictionary *)addParams{
//    if (self = [super init]) {
//        [self additionalParams:addParams];
//    }
//    return self;
//}
//
//-(id)initWithAdditionalParamsBlock:(NSDictionary* (^)(void))addParamsBlock{
//    return [[[self class] alloc] initWithAdditionalParams:addParamsBlock];
//}


- (id)responseObjectFromDict:(NSDictionary *)dict
{
    return dict;
}


@end
