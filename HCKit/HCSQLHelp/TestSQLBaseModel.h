//
//  TestSQLBaseModel.h
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "SQLBaseModel.h"


@interface TestSQLBaseModel : SQLBaseModel
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,assign) NSInteger old;
@end
