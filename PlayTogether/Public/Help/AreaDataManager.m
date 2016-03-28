//
//  AreaDataManager.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/6.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "AreaDataManager.h"

@implementation AreaDataManager

+ (instancetype)sharedManager
{
    static AreaDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AreaDataManager alloc]init];
    });
    return manager;
}

- (NSString*)filePath
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"area"];
    return path;
}

- (void)saveWithObject:(id)obj
{
    BOOL flag = [NSKeyedArchiver archiveRootObject:obj toFile:[self filePath]];
    if (flag) {
        DDLog(@"区域数据缓存完毕");
    }else{
        DDLog(@"缓存失败了");
    }
}

- (id)readAreaData
{
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    return obj;
}

- (BOOL)fileExist
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:[self filePath]];
}

@end
