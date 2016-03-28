//
//  FEUserData.h
//  FinanceExamination
//
//  Created by AD-iOS on 15/7/29.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APUserData : NSObject

+ (instancetype)sharedUserData;

@property (nonatomic, assign, getter=isOnline) BOOL online;

@property (nonatomic, copy) NSString *tokenID;

@property (copy, nonatomic) NSString *userID;

@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *userPassword;

@property (copy, nonatomic) NSString *telephone;

@property (copy, nonatomic) NSString *sex;

@property (copy, nonatomic) NSString *realName;

@property (copy, nonatomic) NSString *idCard;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *alias;

@property (nonatomic, copy) NSString *headerURL;

//用户最后定位坐标
@property (copy, nonatomic) NSString *longitude;

@property (nonatomic, copy) NSString *latitude;
- (void)configData:(NSDictionary*)dict;

@end
