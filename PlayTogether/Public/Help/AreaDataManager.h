//
//  AreaDataManager.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/6.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaDataManager : NSObject

@property (assign, nonatomic, readonly) BOOL fileExist;

+ (instancetype)sharedManager;

- (void)saveWithObject:(id)obj;
- (id)readAreaData;
@end
