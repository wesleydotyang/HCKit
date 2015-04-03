//
//  HCBaseDBHelper.h
//  WrapperSQL
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface HCBaseDBHelper : NSObject
@property (nonatomic,strong) NSString *dbPath;
@property (nonatomic,strong) FMDatabaseQueue *fmDbQueue;
@property(nonatomic, assign)BOOL isOpened;

-(id)initWithDbPath:(NSString *)dbPath;

- (BOOL)open;
-(void)close;

@end

