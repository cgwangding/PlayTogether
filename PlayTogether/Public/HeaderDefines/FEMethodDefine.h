//
//  DLCommon.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/13.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

//#if DEBUG
//#define DDLog(format,...) NSLog(@"[%s][%d]" format,__func__,__LINE__,##__VA_ARGS__)
//#endif

//custom debug
#if DEBUG
#define DDLog(format,...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define DDLog(format,...) nil
#endif

//screen info
#define Screen_Width ([[UIScreen mainScreen]bounds].size.width)
#define Screen_Height ([[UIScreen mainScreen]bounds].size.height)

//iphone version
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//custom storyboard vc
#define StoryBoardVC(boardName,boardID)     [[UIStoryboard storyboardWithName:(boardName) bundle:nil]instantiateViewControllerWithIdentifier:(boardID)]
#define MainStoryBoard(boardID) StoryBoardVC(@"Main",(boardID))


//notification
#define NotificationPost(name, obj)  [[NSNotificationCenter defaultCenter]postNotificationName:(name) object:(obj)]
#define NotificationAdd(observer,selector,name,object)     [[NSNotificationCenter defaultCenter]addObserver:(observer) selector:(selector) name:(name) object:(object)];

//NSUserDefault
#define default_synchronize [[NSUserDefaults standardUserDefaults]synchronize]
#define default_add_Bool(boolean, key) [[NSUserDefaults standardUserDefaults]setBool:(boolean) forKey:(key)]
#define default_get_Bool(key)   [[NSUserDefaults standardUserDefaults]boolForKey:(key)]
#define default_add_Object(obj, key) [[NSUserDefaults standardUserDefaults]setObject:(obj) forKey:(key)]
#define default_get_Object(key)   [[NSUserDefaults standardUserDefaults]objectForKey:(key)]

//UIColor
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r,g,b) RGBA((r),(g),(b),1.0)

#define HexColor(hex) [UIColor colorWithHex:(hex)]

//safe self
#define  WEAKSELF     __weak typeof(self) weakSelf = self;
#define STRONGSELF                     __strong typeof(self) strongSelf = weakSelf;

//application


//UUID
#define UUID    [[UIDevice currentDevice]uuid]

