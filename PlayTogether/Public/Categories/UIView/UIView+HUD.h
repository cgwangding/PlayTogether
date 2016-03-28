//
//  UIView+HUD.h
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/4.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

- (void)showWithStatus:(NSString*)status;

- (void)showWithMessage:(NSString*)status;

- (void)hudHide;

- (void)hideAfterDelay:(NSTimeInterval)delay;
@end
