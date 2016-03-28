//
//  APIManager.h
//  FinanceExamination
//
//  Created by AD-iOS on 15/7/29.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface APIManager : NSObject

+ (void)cancel;

//发送验证码
+ (void)sendVerifyCodeWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//注册
+ (void)registWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//完善信息
+ (void)completeUserInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//获取地区信息
+ (void)areaInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//登录
+ (void)loginWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//忘记密码、找回密码
+ (void)findPwdWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//一键报警
+ (void)alarmQuicklyWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//上传录音文件
+ (void)uploadVoiceFileWithBlock:(void (^)(id<AFMultipartFormData>formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

//语音报警
+ (void)audioAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//上传图片文件
+ (void)uploadImageFileWithBlock:(void (^)(id<AFMultipartFormData>formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

//图片报警
+ (void)imageAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//文字报警
+ (void)textAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//获取个人信息
+ (void)personalInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//修改密码
+ (void)modifyPwdWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//修改头像
+ (void)modifyUserHeaderWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//修改地址
+ (void)modifyAddressWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//意见反馈
+ (void)suggestWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//获取新闻
+ (void)newsWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//获取通告资讯
+ (void)noticeWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//收藏新闻
+ (void)collectionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//取消收藏
+ (void)cancelCollWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//个人收藏，我的收藏
+ (void)myCollectionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//预约地址
+ (void)orderAddressWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//预约
+ (void)orderedWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//报警记录
+ (void)alarmHistoryWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//上报报警位置
+ (void)uploadPostionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//报警记录详情
+ (void)alarmHistoryDetailWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//我的预约
+ (void)myOrderWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//删除报警记录
+ (void)deleteAlarmHistoryWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//查询警察位置
+ (void)policePositionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//查询案件的状态
+ (void)alarmStateWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//取消报警
+ (void)cancelAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//修改个人信息
+ (void)modifyPersonalInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

@end
