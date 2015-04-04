//
//  SQLBaseModel.h
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLHelper.h"
#import "FMResultSet.h"
static inline NSString *getDocumentPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

@protocol SQLBaseModelProtocol <NSObject>
+(instancetype)model;
@end


@interface SQLBaseModel : NSObject<NSCoding,SQLBaseModelProtocol>
@property (nonatomic,strong) SQLHelper *sqlHelper;
@property (nonatomic,strong) NSString *dbPath;
+(instancetype)model;
+ (NSArray *)properties;

- (NSDictionary *)properties_aps;
-(id)initWithDictionary:(NSDictionary *)dic;
-(id)initWithFMResultSet:(FMResultSet *)result;

@end
