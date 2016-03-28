//
//  UIView+Hook.m
//  HUDDemo
//
//  Created by AD-iOS on 16/1/4.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "UIView+Hook.h"
#import <objc/runtime.h>

static const char *currentViewKey = "currentViewKey";

@implementation UIView (Hook)

- (void)setCurrentView:(UIView *)currentView
{
    objc_setAssociatedObject(self, &currentViewKey, currentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)currentView
{
   return objc_getAssociatedObject(self, &currentViewKey);
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{

}

- (void)didMoveToSuperview
{

}

- (void)willMoveToWindow:(nullable UIWindow *)newWindow
{
//    DDLog(@"%@",newWindow);
}

- (void)didMoveToWindow
{
//    const char *name = object_getClassName(self);
//    NSString *className = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//    if ([className hasPrefix:@"UI"] == NO && [className hasPrefix:@"_"] == NO && [className hasPrefix:@"BMK"] == NO) {
//        DDLog(@"%@",self);
//        self.currentView = self;
//    }
}

@end
