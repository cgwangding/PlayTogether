//
//  UIApplication+EnablePush.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/8.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (EnablePush)

+ (BOOL)checkPush;

+ (BOOL)checkPushWithHint:(NSString*)hint;

@end
