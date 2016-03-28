//
//  DLInterfaceDefines.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/13.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

//正式地址http://116.228.89.136:40011
//测试地址http://10.40.200.56:8080
//客户地址http://139.196.179.24:40011
#define BaseInterfaceURL                  @"http://116.228.89.136:40011"

//获取地区
#define APGetAreaInfoInterface              @"/DiDiAlarm/loginApp.do?p=findCityArea"

//注册
#define APRegistInterface              @"/DiDiAlarm/loginApp.do?p=register"

//发送手机验证码
#define APSendVerifyCodeInterface              @"/DiDiAlarm/loginApp.do?p=regsiterByPhone"

//完善用户信息
#define APCompeleteUserInfoInterface              @"/DiDiAlarm/ loginApp.do?p=singLogin"

//登录
#define APLoginInterface              @"/DiDiAlarm/loginApp.do?p=peopleLoginApp"

//忘记密码、找回密码
#define APForgotPwdInterface              @"/DiDiAlarm/loginApp.do?p=forgotPasswordToNew"

/**
 *  报警
 */

//一键报警
#define APAlarmQuicklyInterface              @"/DiDiAlarm/Alarm.do?p=callByOneKey"

//上传录音文件
#define APUploadVoiceInterface              @"/DiDiAlarm/Alarm.do? p=checkFile"

//语音报警
#define APAudioAlarmInterface              @"/DiDiAlarm/Alarm.do?p=callByVoice"

//图片报警-上传图片
#define APUploadImageInterface              @"/DiDiAlarm/Alarm.do?p=checImgkFile"

//图片报警-报警
#define APImageAlarmInterface              @"/DiDiAlarm/Alarm.do?p=callByImg"

//文字报警
#define APTextAlarmInterface              @"/DiDiAlarm/Alarm.do?p=callByText"

//上报报警人位置
#define APUploadPositionInterface              @"/DiDiAlarm/Alarm.do?p=peoplePostition"

//查询警察位置
#define APGetPolicePositonInterface              @"/DiDiAlarm/Alarm.do?p=receiveIsWhere"

//查询报警的状态
#define APGetAlarmStateInterface              @"/DiDiAlarm/Alarm.do?p=findCallStatus"

//取消报警
#define APCancelAlarmInterface              @"/DiDiAlarm/Alarm.do?p=cancleAlarm"

/**
 *  个人中心
 */
//获取个人信息
#define APGetPersonalInfoInterface              @"/DiDiAlarm/member.do?p=appEyeView"

//修改密码
#define APModifyPwdInterface              @"/DiDiAlarm/member.do?p=editPassword"

//修改头像
#define APModifyUserHeaderInterface              @"/DiDiAlarm/member.do?p=editFile"

//修改地址
#define APModifyAddrInterface              @"/DiDiAlarm/member.do?p=editAddress"

//修改个人信息
#define APModifyPersonalInfoInterface              @"/DiDiAlarm/member.do?p=editInformation"

//意见反馈
#define APSubmitSuggestInterface              @"/DiDiAlarm/member.do?p=saveMessage"

//报警记录
#define APAlarmHistoryInterface              @"/DiDiAlarm/member.do?p=findCall"

//报警记录详情
#define APAlarmHistoryDetailInterface              @"/DiDiAlarm/member.do?p=findDetailedCall"

//我的预约
#define APMyOrderInteface              @"/DiDiAlarm/member.do?p=findOrder"

//删除报警记录
#define APDeleteAlarmHistoryInterface              @"/DiDiAlarm/member.do?p=deleteCall"

/**
 *  预约
 */
//预约地址
#define APOrderAddressInterface              @"/DiDiAlarm/member.do?p=findPolice"

//预约
#define APOrderInterface              @"/DiDiAlarm/member.do?p=saveUserOrder"

/**
 *  资讯
 */

//获取新闻资讯
#define APNewsInterface              @"/DiDiAlarm/member.do?p=findAllNews2"

//通告新闻资讯
#define APNoticeInterface              @"/DiDiAlarm/member.do?p=findAllNews3"

//收藏新闻
#define APCollectionInterface              @"/DiDiAlarm/member.do?p=collectNews"

//取消收藏
#define APCancelCollInterface              @"/DiDiAlarm/member.do?p=cancelNews"

//个人收藏
#define APMyCollectionInterface              @"/DiDiAlarm/member.do?p=findNews"

