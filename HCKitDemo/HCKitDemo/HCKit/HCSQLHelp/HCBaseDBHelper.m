//
//  HCBaseDBHelper.m
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCBaseDBHelper.h"

@implementation HCBaseDBHelper
-(id)initWithDbPath:(NSString *)dbPath{
    if (self = [super init]) {
        self.dbPath = dbPath;
    }
    return self;
}


- (BOOL)open {
    if (self.isOpened) {
        return YES;
    }
    FMDatabaseQueue *q = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    if (!q) {
        return NO;
    }
    self.fmDbQueue = q;

    
    BOOL isDBFileExisted = [self isDBFileExisted];
    if (isDBFileExisted) {
        
    }else{
        
    }
    self.isOpened = YES;
    return YES;
}
-(void)close{
    [self.fmDbQueue close];
    self.isOpened = NO;
}

#pragma mark ---

#pragma mark - Aux Methods

- (BOOL)isDBFileExisted {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.dbPath];
}

- (void)removeDBFile {
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dbPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.dbPath error:nil];
    }
}

@end
