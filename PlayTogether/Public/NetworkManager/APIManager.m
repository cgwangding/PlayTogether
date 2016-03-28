//
//  APIManager.m
//  FinanceExamination
//
//  Created by AD-iOS on 15/7/29.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "APIManager.h"
#import "HTTPClient.h"

@implementation APIManager

+ (void)cancel
{
    [[HTTPClient sharedClient]cancel];
}

//发送验证码
+ (void)sendVerifyCodeWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APSendVerifyCodeInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//注册
+ (void)registWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APRegistInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//完善信息
+ (void)completeUserInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APCompeleteUserInfoInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//获取地区信息
+ (void)areaInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APGetAreaInfoInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//登录
+ (void)loginWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APLoginInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//忘记密码、找回密码
+ (void)findPwdWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APForgotPwdInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//一键报警
+ (void)alarmQuicklyWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APAlarmQuicklyInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//上传录音文件
+ (void)uploadVoiceFileWithBlock:(void (^)(id<AFMultipartFormData>formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [[HTTPClient sharedClient]post:APUploadVoiceInterface constructingBodyWithBlock:block success:success failure:failure];
}

//语音报警
+ (void)audioAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APAudioAlarmInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//上传图片文件
+ (void)uploadImageFileWithBlock:(void (^)(id<AFMultipartFormData>formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [[HTTPClient sharedClient]post:APUploadImageInterface constructingBodyWithBlock:block success:success failure:failure];
}

//图片报警
+ (void)imageAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APImageAlarmInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//文字报警
+ (void)textAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APTextAlarmInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//获取个人信息
+ (void)personalInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APGetPersonalInfoInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//修改密码
+ (void)modifyPwdWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APModifyPwdInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//修改头像
+ (void)modifyUserHeaderWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APModifyUserHeaderInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//修改地址
+ (void)modifyAddressWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APModifyAddrInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//意见反馈
+ (void)suggestWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APSubmitSuggestInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//获取新闻
+ (void)newsWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APNewsInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//获取通告资讯
+ (void)noticeWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APNoticeInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//收藏新闻
+ (void)collectionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APCollectionInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//取消收藏
+ (void)cancelCollWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APCancelCollInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//个人收藏，我的收藏
+ (void)myCollectionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APMyCollectionInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//预约地址
+ (void)orderAddressWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APOrderAddressInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//预约
+ (void)orderedWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APOrderInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//报警记录
+ (void)alarmHistoryWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APAlarmHistoryInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//上报报警位置
+ (void)uploadPostionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APUploadPositionInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//报警记录详情
+ (void)alarmHistoryDetailWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APAlarmHistoryDetailInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//我的预约
+ (void)myOrderWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APMyOrderInteface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//删除报警记录
+ (void)deleteAlarmHistoryWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APDeleteAlarmHistoryInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//查询警察位置
+ (void)policePositionWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APGetPolicePositonInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//查询案件的状态
+ (void)alarmStateWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APGetAlarmStateInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//取消报警
+ (void)cancelAlarmWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APCancelAlarmInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//修改个人信息
+ (void)modifyPersonalInfoWithParams:(NSDictionary*)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [HTTPClient post:APModifyPersonalInfoInterface bodyParams:params success:^(NSDictionary *dict) {
        if (success) {
            success(dict);
        }
    } dataError:^(NSInteger code, NSString *message) {
        if (error) {
            error(code,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end