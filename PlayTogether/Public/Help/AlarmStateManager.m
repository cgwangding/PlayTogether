//
//  AlarmStateManager.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/15.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "AlarmStateManager.h"

#define FilePath     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"alarmState"]


@implementation AlarmStateManager

+ (instancetype)manager
{
    static AlarmStateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AlarmStateManager alloc]init];
    });
    return manager;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.hadAlarmed = [aDecoder decodeBoolForKey:@"hadAlarmed"];
        self.hadRecived = [aDecoder decodeBoolForKey:@"hadRecived"];
        self.ownAddr = [aDecoder decodeObjectForKey:@"ownAddr"];
        self.policeName = [aDecoder decodeObjectForKey:@"policeName"];
        self.policePhoneNum = [aDecoder decodeObjectForKey:@"policePhoneNum"];
        self.distance = [aDecoder decodeObjectForKey:@"distance"];
        self.timeForArrive = [aDecoder decodeObjectForKey:@"timeForArrive"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.hadAlarmed forKey:@"hadAlarmed"];
    [aCoder encodeBool:self.hadRecived forKey:@"hadRecived"];
    [aCoder encodeObject:self.ownAddr forKey:@"ownAddr"];
    [aCoder encodeObject:self.policeName forKey:@"policeName"];
    [aCoder encodeObject:self.policePhoneNum forKey:@"policePhoneNum"];
    [aCoder encodeObject:self.distance forKey:@"distance"];
    [aCoder encodeObject:self.timeForArrive forKey:@"timeForArrive"];
}

- (void)saveState
{
    BOOL succeed = [NSKeyedArchiver archiveRootObject:self
                                               toFile:FilePath];
    if (succeed) {
        DDLog(@"保存成功");
    }else{
        DDLog(@"保存失败");
    }
}

- (AlarmStateManager*)getAlarmState
{
    AlarmStateManager *stateManager = [AlarmStateManager manager];
    AlarmStateManager *manger = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
    stateManager.hadAlarmed = manger.hadAlarmed;
    stateManager.hadRecived = manger.hadRecived;
    stateManager.ownAddr = manger.ownAddr;
    stateManager.policeName = manger.policeName;
    stateManager.policePhoneNum = manger.policePhoneNum;
    stateManager.distance = manger.distance;
    stateManager.timeForArrive = manger.timeForArrive;
    
    return manger;
}

#pragma mark - getter and setter 

- (void)setHadAlarmed:(BOOL)hadAlarmed
{
    _hadAlarmed = hadAlarmed;
    [AlarmStateManager manager].hadRecived = NO;
    [AlarmStateManager manager].hadReject = NO;
    [AlarmStateManager manager].ownAddr = @"";
    [AlarmStateManager manager].policeName = @"";
    [AlarmStateManager manager].policePhoneNum = @"";
    [AlarmStateManager manager].distance = @"";
    [AlarmStateManager manager].shouldLocationContinue = NO;
    [self saveState];
}

- (void)setHadRecived:(BOOL)hadRecived
{
    _hadRecived = hadRecived;
    [self saveState];
}
- (void)setHadReject:(BOOL)hadReject
{
    _hadReject = hadReject;
    [AlarmStateManager manager].hadRecived = NO;
    [AlarmStateManager manager].ownAddr = @"";
    [AlarmStateManager manager].policeName = @"";
    [AlarmStateManager manager].policePhoneNum = @"";
    [AlarmStateManager manager].distance = @"";
    [AlarmStateManager manager].shouldLocationContinue = NO;
    [self saveState];
}

- (void)setOwnAddr:(NSString *)ownAddr
{
    _ownAddr = ownAddr;
    [self saveState];
}

- (void)setPoliceName:(NSString *)policeName
{
    _policeName = policeName;
    [self saveState];
}

- (void)setPolicePhoneNum:(NSString *)policePhoneNum
{
    _policePhoneNum = policePhoneNum;
    [self saveState];
}

- (void)setDistance:(NSString *)distance
{
    _distance = distance;
    [self saveState];
}

- (void)setTimeForArrive:(NSString *)timeForArrive
{
    _timeForArrive = timeForArrive;
    [self saveState];
}

- (void)setRejectReson:(NSString *)rejectReson
{
    _rejectReson = rejectReson;
    [self saveState];
}

- (void)setShouldLocationContinue:(BOOL)shouldLocationContinue
{
    _shouldLocationContinue = shouldLocationContinue;
    [self saveState];
}

@end
