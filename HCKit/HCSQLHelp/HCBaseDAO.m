//
//  HCBaseDAO.m
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCBaseDAO.h"

@implementation HCBaseDAO
+(instancetype)dao{
    NSAssert(NO, @"子类实现");
    return nil;
}


-(id)initWithSQLModel:(SQLBaseModel*)baseModel{
    if (self = [super init]) {
        _baseModel = baseModel;
        [self.baseDBHelper open];
    }
    return self;
}

#pragma mark creat upgrade
-(BOOL)creatOrUpgradeTable{
    __block BOOL flag = NO;
    NSString *creatSql = [self.baseModel.sqlHelper creatString];
    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        flag = [db executeUpdate:creatSql];
    }];
    PADBQuickCheck(flag);
    if (flag) {
        flag = [self upgradeTable];
    }
    return flag;
    
}


-(BOOL)upgradeTable{
    __block BOOL flag = YES;

    NSArray *adds = [self objectIn:self.baseModel.sqlHelper.fields withOut:[self getTableFields]];
    NSArray *drops = [self objectIn:[self getTableFields] withOut:self.baseModel.sqlHelper.fields];

    [self.fmDbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSString *field in adds) {
            NSString *type =self.baseModel.sqlHelper.types[[self.baseModel.sqlHelper.fields indexOfObject:field]];
            NSString *addSql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",[self tableName],field,type];
            flag = flag&&[db executeUpdate:addSql];
        }
        
//        for (NSString *field in drops) {
//            NSString *dropSql = [NSString stringWithFormat:@"ALTER TABLE %@ DROP COLUMN %@",[self tableName],field];
//            flag = flag&&[db executeUpdate:dropSql];
//        }
        if (drops.count>0) {
            DebugAssert(NO, @"少定义字段");
        }
        
        PADBTransactionSQLCheck(flag,rollback);

    }];

    return flag;
    
}

#pragma mark insert or replace
-(BOOL)insertWithModel:(SQLBaseModel*)baseModel{
    __block BOOL flag;
    NSDictionary *dic = [baseModel properties_aps];
    
    NSArray *tableFields =self.baseModel.sqlHelper.fields;

    NSArray *both = [self objectIn:dic.allKeys andIn:tableFields];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *field in both) {
        [mdic setObject:[dic objectForKey:field] forKey:field];
    }
    NSString *sql = [self createInsertSqlByDictionary:mdic tablename:self.tableName];

    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        flag = [db executeUpdate:sql withParameterDictionary:mdic];
    }];
    
    return flag;
}

-(BOOL)insertOrReplaceWithModel:(SQLBaseModel *)baseModel{
    __block BOOL flag;
    
    NSDictionary *dic = [baseModel properties_aps];
    
    NSArray *tableFields =self.baseModel.sqlHelper.fields;
    
    NSArray *both = [self objectIn:dic.allKeys andIn:tableFields];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *field in both) {
        [mdic setObject:[dic objectForKey:field] forKey:field];
    }
    NSString *sql = [self createInsertOrReplaceSqlByDictionary:mdic tablename:self.tableName];

    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        flag = [db executeUpdate:sql withParameterDictionary:mdic];
    }];
    return flag;
}

#pragma mark read
-(NSArray *)selectAll{
    __block NSMutableArray *models = [NSMutableArray array];
    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db selectResultsFrom:self.tableName orderBy:nil error:nil];
        while ([rs next]) {
            SQLBaseModel *model = [[[self.baseModel class] alloc] initWithFMResultSet:rs];
            [models addObject:model];
        }
        [rs close];
    }];
    return models;
}

#pragma mark delete or remove

-(BOOL)dropTable{
    __block BOOL flag;
    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        flag = [db executeUpdate:self.baseModel.sqlHelper.dropTableString];
    }];
    return flag;
    PADBQuickCheck(flag);
}



-(NSString *)createInsertSqlByDictionary:(NSDictionary *)dict tablename:(NSString *)table{
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"insert into %@ (",table] ;
    NSInteger i = 0;
    for (NSString *key in dict.allKeys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@",key];
        i++;
    }
    [sql appendString:@") values ("];
    i = 0;
    for (NSString *key in dict.allKeys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@":%@",key];
        i++;
    }
    [sql appendString:@")"];
    return sql;
}
-(NSString *)createInsertOrReplaceSqlByDictionary:(NSDictionary *)dict tablename:(NSString *)table{
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"INSERT OR REPLACE INTO %@ (",table] ;
    NSInteger i = 0;
    for (NSString *key in dict.allKeys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@",key];
        i++;
    }
    [sql appendString:@") values ("];
    i = 0;
    for (NSString *key in dict.allKeys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@":%@",key];
        i++;
    }
    [sql appendString:@")"];
    return sql;
}



-(NSArray *)objectIn:(NSArray *)array1 andIn:(NSArray *)array2{
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"(SELF IN %@)",array2];
    NSArray * filter = [array1 filteredArrayUsingPredicate:filterPredicate];
    return filter;
}


-(NSArray *)objectIn:(NSArray *)array1 withOut:(NSArray *)array2{
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",array2];
    NSArray * filter = [array1 filteredArrayUsingPredicate:filterPredicate];
    return filter;
}

-(NSArray *)getTableFields{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ limit 1",self.baseModel.sqlHelper.tableName];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        for (int i = 0; i<rs.columnCount; i++) {
            [array addObject:[rs columnNameForIndex:i]];
        }
        [rs close];
    }];
    return array;
}



-(NSString *)tableName{
    return self.baseModel.sqlHelper.tableName;
}

-(HCBaseDBHelper *)baseDBHelper{
    if (!_baseDBHelper) {
        _baseDBHelper =[[HCDBManager shared] dbHelperWithDbPath:self.baseModel.dbPath];
        if (!_baseDBHelper) {
            _baseDBHelper = [[HCBaseDBHelper alloc] initWithDbPath:self.baseModel.dbPath];
            [[HCDBManager shared] addDBHelper:_baseDBHelper];
        }
    }
    return _baseDBHelper;
}

-(FMDatabaseQueue*)fmDbQueue{
    if (!_fmDbQueue) {
        _fmDbQueue = self.baseDBHelper.fmDbQueue;
    }
    return _fmDbQueue;
}
@end
