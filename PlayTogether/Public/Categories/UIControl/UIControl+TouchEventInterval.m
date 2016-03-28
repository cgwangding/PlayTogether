//
//  UIControl+TouchEventInterval.m
//  CompetitionApply
//
//  Created by AD-iOS on 15/12/7.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "UIControl+TouchEventInterval.h"

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptedEventTime = "UIControl_acceptedEventTime";

@implementation UIControl (TouchEventInterval)

+ (void)load
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__wd_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)__wd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([[NSDate date] timeIntervalSince1970] - self.wd_acceptedEventTime < self.wd_acceptEventInterval) {
        return;
    }
    if (self.wd_acceptEventInterval > 0) {
        self.wd_acceptedEventTime = [[NSDate date] timeIntervalSince1970];
    }
    [self __wd_sendAction:action to:target forEvent:event];
}

- (NSTimeInterval)wd_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setWd_acceptEventInterval:(NSTimeInterval)wd_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(wd_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)wd_acceptedEventTime
{
    return [objc_getAssociatedObject(self, UIControl_acceptedEventTime) doubleValue];
}

- (void)setWd_acceptedEventTime:(NSTimeInterval)wd_acceptedEventTime
{
    objc_setAssociatedObject(self, UIControl_acceptedEventTime, @(wd_acceptedEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
