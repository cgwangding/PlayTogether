//
//  DLMessageDefine.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/20.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#define DLShowToast(message) [InCommonUse showMessage:(message)]

#define DLShowLoadAnimation   [SVProgressHUD showWithStatus:@"加载中……"]
#define DLHideLoadAnimation [SVProgressHUD dismiss]

#define APShowLoading                  [self.view showWithStatus:@"加载中……"]
#define APHide                      [strongSelf.view hudHide]
#define APShowServiceError                      [strongSelf.view showWithMessage:@"服务器不给力，请稍后重试~~"]



#define DLMessageLoading              @"加载中..."
#define DLMessageLogining              @"登录中..."
#define DLMessageRegisting              @"注册中..." 

#define DLMessageNetWorkUnReach              @"网络不给力~~" 

#define DLMessageNeedValidUserName              @"请输入正确的手机号或邮箱"
#define DLMessageNeedUserName              @"用户名不能为空"
#define DLMessageNeedPwd              @"密码不能为空"
#define DLMessageNeedValidPwd              @"请输入有效的密码"
#define DLMessageNeedAgainPwd              @"请再次输入密码" 
#define DLMessageNeedSamePwd              @"您两次输入的密码不一致"
#define DLMessageVerifyCodeSent              @"验证码已发送"
#define DLMessageVerifyCodeFailed              @"验证码错误"

#define DLMessageRegistSucced              @"注册成功，请登录"
#define DLMessageRegistNeedActiveEMail              @"注册成功，请前往邮箱激活" 
#define DLMessageEMailUnactived               @"邮箱未激活"
#define DLMessageRegistFailed              @"注册失败"

#define CAMessageApplySuccess              @"报名成功"
#define CAMessageApplyFailed              @"报名失败"



