//
//  TestSQLBaseModel.m
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "TestSQLBaseModel.h"
#import "objc/runtime.h"
@implementation TestSQLBaseModel


+(instancetype)model{
    TestSQLBaseModel *model = [[TestSQLBaseModel alloc] init];
    model.dbPath = [TestSQLBaseModel getPath];
    
    model.sqlHelper = [SQLHelper CreatWithTableName:@"testSqlBase"];
    [model.sqlHelper addType:@"VARCHAR(256) PRIMARY KEY" field:@"userId"];
    [model.sqlHelper addType:@"VARCHAR(256)" field:@"name"];
    [model.sqlHelper addType:@"VARCHAR(256)" field:@"sex"];
    [model.sqlHelper addType:@"INTEGER" field:@"old"];

    

    return model;
}
-(id)initWithDictionary:(NSDictionary *)dic{
//    self = [[self class] model];
//    NSDictionary *class_names = [self properties_class_name];
    if (self = [super initWithDictionary:dic]) {
        self.userId = [dic objectForKey:@"userId"];
        self.old = [[dic objectForKey:@"old"] intValue];
    }
    return self;
}

-(id)initWithFMResultSet:(FMResultSet *)result{
    if (self = [super initWithFMResultSet:result]) {
        self.userId = [result stringForColumn:@"userId"];
        self.old = [result intForColumn:@"old"];
        self.sex = [result stringForColumn:@"sex"];
        self.name = [result stringForColumn:@"name"];
    }
    return self;
}



+(NSString *)getPath{
    NSString *docsPath = getDocumentPath();
    NSString *dbFolderPath = [docsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",@"test"]];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFolderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dbFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    if (!error) {
        return  [docsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/%@",@"test",@"test.db"]];
    }
    return nil;
}



@end
