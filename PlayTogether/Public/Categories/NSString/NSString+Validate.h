//
//  NSString+Validate.h
//  AlarmPolice
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

//判断字符串空
- (BOOL)isBlankString;
//判断是否有输入字符，空格与换行不算
- (BOOL)isNilString;

//邮箱验证
- (BOOL)isValidateEmail;
//手机号码验证
- (BOOL)isValidateMobile;

//车牌号验证
- (BOOL)isValidateCarNo;
//用户名
- (BOOL)isValidateUserName;
//密码
- (BOOL)isValidatePassword;
//昵称
- (BOOL)isValidateNickname;
//身份证号
- (BOOL)isValidateIdentityCard;

@end
