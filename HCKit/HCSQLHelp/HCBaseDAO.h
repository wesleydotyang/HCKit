//
//  HCBaseDAO.h
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCBaseDBHelper.h"
#import "FMDB.h"
#import "SQLBaseModel.h"
#import "HCDBManager.h"
#import "FMDBHelpers.h"
#import "SQLBaseModel.h"


#define PADBQuickCheck(SomeBool)            \
{                                           \
if (!(SomeBool)) {                      \
DebugAssert(NO, @"Sql Failure");    \
}                                       \
}

#ifdef DEBUG
#define DebugAssert(cnd, prompt)  NSAssert((cnd), (prompt))
#else
#define DebugAssert(cnd, prompt)
#endif

#define PADBQuickCheck(SomeBool)            \
{                                           \
if (!(SomeBool)) {                      \
DebugAssert(NO, @"Sql Failure");    \
}                                       \
}

#define PADBTransactionSQLCheck(SomeBool, rollBack)             \
{                                                               \
if (!(SomeBool)) {                                          \
DebugAssert(NO, @"Sql Failuer in Transaction");         \
if (rollBack != nil)                                    \
*(rollBack) = YES;                                  \
return;                                                 \
}                                                           \
}



@interface HCBaseDAO : NSObject
@property (nonatomic,strong) SQLBaseModel *baseModel;
@property (nonatomic,strong) FMDatabaseQueue *fmDbQueue;
@property (nonatomic,strong) HCBaseDBHelper *baseDBHelper;
+(instancetype)dao;
-(id)initWithSQLModel:(SQLBaseModel*)baseModel;
-(NSString *)tableName;
-(BOOL)creatOrUpgradeTable;
/**
 *  model中没有赋值的属性在插入时会被忽略
 */
-(BOOL)insertWithModel:(SQLBaseModel*)baseModel;
/**
 *  model中没有赋值的属性在插入时会被忽略
 */

-(BOOL)insertOrReplaceWithModel:(SQLBaseModel *)baseModel;

-(NSArray *)selectAll;
@end
