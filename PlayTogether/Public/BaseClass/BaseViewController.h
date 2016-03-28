//
//  BaseViewController.h
//  Tuchu
//
//  Created by Lingday on 15/4/20.
//  Copyright (c) 2015年 Lingday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic,strong) NSMutableArray *infoDataArray;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (assign, nonatomic) BOOL isNetworkReachable;

//右边button
- (void)rightAction;
//右边button
-(void)leftAction;
//子类用这个方法来改变导航栏的颜色
- (UIColor*)navigaitonBarBackgroundColor;
//子类用这个方法来改变导航栏文字的颜色
- (NSDictionary*)navigationBarTitleTextAttribute;

//集成上下拉刷新



/**
 *  隐藏或显示“无结果”提示，默认隐藏。
 *
 *  @param hidden boolean
 */
- (void)resultMessageHidden:(BOOL)hidden;
/**
 *  当调用上面的方法并且参数为NO时，需要调用该方法
 *
 *  @param frame label的frame
 */
- (void)resetResultMessageFrame:(CGRect)frame;

@end


UIKIT_EXTERN NSString *const HadLoginAtAnotherPlaceNotification;

UIKIT_EXTERN NSString *const HadPresentedKey;
