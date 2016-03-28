//
//  HTTPClient+AlertViewDelegate.m
//  AlarmPolice
//
//  Created by AD-iOS on 16/1/11.
//  Copyright © 2016年 Adinnet. All rights reserved.
//

#import "HTTPClient+AlertViewDelegate.h"

@implementation HTTPClient (AlertViewDelegate)

- (void)alertViewCancel:(UIAlertView *)alertView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ShouldShowLoginNotification object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

@end
