//
//  NSString+Validate.m
//  AlarmPolice
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

- (BOOL)isBlankString
{
    if (self != nil && ![self isEqual:[NSNull null]] && ![self isEqualToString:@""] ) {
        return NO;
    }
    return YES;
}

- (BOOL)isNilString
{
    if (self == nil || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] == nil) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


//手机号码验证
- (BOOL)isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$
    NSString *phoneRegex = @"^(13|14|15|17|18)\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//车牌号验证
- (BOOL)isValidateCarNo
{
    NSString *carRegex = @"^[\\u4e00-\\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}
//用户名
- (BOOL)isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}


//密码
- (BOOL)isValidatePassword
{
    //    NSString *passWordRegex = @"(?!^\\d+$)(?!^[a-zA-Z]+$)[0-9a-zA-Z]{6,16}";
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![_]+$)[0-9a-zA-Z_]{6,16}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//昵称
- (BOOL)isValidateNickname
{
    NSString *nicknameRegex = @"^[\\u4e00-\\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//身份证号
- (BOOL)isValidateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}



@end
