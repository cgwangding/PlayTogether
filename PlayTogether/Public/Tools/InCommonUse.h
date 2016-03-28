//
//  InCommonUse.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/19.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InCommonUse : NSObject

//显示消息
+ (void)showMessage:(NSString*)message;

+ (void)showServerError:(NSInteger)code;

//显示加载动画
+ (void)showActivityIndicator;
//隐藏加载动画
+ (void)activityIndicatorHide;


//验证设备摄像头是否可用
+ (BOOL)isDeviceCameraAvailable;
+ (BOOL)isDeviceFrontCameraAvailable;
// 相册是否可用
+ (BOOL) isPhotoLibraryAvailable;
//验证设备时候可以使用指南针
+ (BOOL)isDeviceMagnetometerAvailable;


+(NSString*)updateTime:(NSString*)paramTime;//显示昨天几点  今天几点
@end
