//
//  DLMessageDefine.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/20.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#define DLShowToast(message) [SVProgressHUD showInfoWithStatus:(message)]

#define DLShowLoadAnimation   [SVProgressHUD showWithStatus:@"加载中……"]
#define DLHideLoadAnimation [SVProgressHUD dismiss]

#define APShowLoading                  [self.view showWithStatus:@"加载中……"]
#define APHide                      [strongSelf.view hudHide]
#define APShowServiceError                      [strongSelf.view showWithMessage:@"服务器不给力，请稍后重试~~"]



#define DLMessageLoading              @"加载中..."
#define DLMessageLogining              @"登录中..."
#define DLMessageRegisting              @"注册中..." 

#define DLMessageNetWorkUnReach              @"网络不给力~~" 

#define PTMessageNotRegist              @"用户未注册" 
#define PTMessageIncorrectUserNameOrPassword              @"用户名或密码错误"



