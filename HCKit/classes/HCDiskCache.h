//
//  HCDiskCache.h
//  PAQZZ
//
//  Created by 花晨 on 14-2-14.
//  Copyright (c) 2014年 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDiskCache : NSObject<NSCoding>
+ (instancetype)shared;
-(void)addObject:(id)obj key:(NSString *)keyName;
-(id)objectForKey:(NSString *)keyName;
-(void)removeObjectForKey:(NSString *)keyName;


/**
 *  文件存放路径，在初始化后立即修改有效。供子类修改
 */
@property (nonatomic,strong) NSString *filePath;

@end
