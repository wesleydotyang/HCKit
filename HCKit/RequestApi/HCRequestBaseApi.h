//
//  HCRequestBaseApi.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-16.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface HCRequestBaseApi : NSObject{

}

@property (nonatomic,strong) NSString *operation;
@property (nonatomic,strong) NSMutableDictionary *parameters;
@property (nonatomic,strong) NSString *httpMethod;
-(NSDictionary *)baseParams;

//-(id)initWithAdditionalParams:(NSDictionary *)addParams;
-(void)additionalParams:(NSDictionary *)addParams;
- (id)responseObjectFromDict:(NSDictionary *)dict;

//-(id)initWithAdditionalParamsBlock:(NSDictionary* (^)(void))addParamsBlock;
@end
