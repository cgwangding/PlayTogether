//
//  UIApplication+EnablePush.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/8.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "UIApplication+EnablePush.h"

@implementation UIApplication (EnablePush)

+ (BOOL)checkPush
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] > 8.0) {
        return [[UIApplication sharedApplication]isRegisteredForRemoteNotifications];
    }
    if ([[UIApplication sharedApplication]enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone) {
        //用户拒绝推送
        return NO;
    }
    return YES;
}

+ (BOOL)checkPushWithHint:(NSString*)hint
{
    if ([self checkPush] == NO) {
        //
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"未获得授权使用推送" message:hint delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    return YES;
}

@end
