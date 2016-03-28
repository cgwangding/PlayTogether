//
//  UIView+HUD.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/4.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"

@implementation UIView (HUD)

- (void)showWithStatus:(NSString*)status
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = status;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.cornerRadius = 3;
    hud.yOffset = -50;
//    hud.color = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    
}

- (void)showWithMessage:(NSString*)status
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = status;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.cornerRadius = 3;
    hud.yOffset = -50;
//    hud.color = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    [hud hide:YES afterDelay:0.8];
}

- (void)hudHide
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)hideAfterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    [hud hide:YES afterDelay:delay];
}


@end
