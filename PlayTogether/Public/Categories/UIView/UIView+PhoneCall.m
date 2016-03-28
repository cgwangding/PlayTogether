

//
//  UIView+PhoneCall.m
//  AlarmPolice
//
//  Created by AD-iOS on 15/12/30.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "UIView+PhoneCall.h"

@implementation UIView (PhoneCall)

- (void)phoneCallWithPhone:(NSString*)number
{
    NSString * str=[[NSString alloc] initWithFormat:@"tel:%@",number];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}

@end
