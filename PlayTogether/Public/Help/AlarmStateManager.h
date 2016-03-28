//
//  AlarmStateManager.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmStateManager : NSObject<NSCoding>

+ (instancetype)manager;

//是否已经报警，为YES时，表示已经报警。NO表示没有报警，后在的属性无效
@property (assign, nonatomic) BOOL hadAlarmed;

//是否已经有人接警，NO没有人接受，显示报警页面。YES已经接受，显示接警人的信息以及
@property (assign, nonatomic) BOOL hadRecived;

//是否已经拒绝
@property (assign, nonatomic) BOOL hadReject;

//记录自己的地址
@property (copy, nonatomic) NSString *ownAddr;

/**
 *  警察的名字
 */
@property (copy, nonatomic)  NSString *policeName;

/**
 *  警察的地址
 */
@property (copy, nonatomic) NSString *policePhoneNum;

/**
 *  警察距离报警人的距离
 */
@property (copy, nonatomic) NSString *distance;

/**
 *  警察赶到案发地的时间,使用了固定速度估算，该属性暂时无用
 */
@property (copy, nonatomic) NSString *timeForArrive;


/**
 *  拒接理由
 */
@property (copy, nonatomic) NSString *rejectReson;


/**
 *  是否继续保持定位状态
 */
@property (assign, nonatomic) BOOL shouldLocationContinue;


/**
 *  保存并且更新状态
 */
- (void)saveState;

/**
 *  获取报警状态
 *
 *  @return 保存状态的对象
 */
- (AlarmStateManager*)getAlarmState;

@end
