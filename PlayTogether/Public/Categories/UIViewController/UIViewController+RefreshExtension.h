//
//  UIViewController+RefreshExtension.h
//  AlarmPolice
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RefreshExtension)

//添加上下拉刷新或者全部添加
- (void)addALLRefreshWithScrollView:(UIScrollView*)scrollView;
- (void)addHeaderRefreshWithScrollView:(UIScrollView*)scrollView;
- (void)addFootrerRefreshWithScrollView:(UIScrollView*)scrollView;

/**
 *  子类需要重载
 */
- (void)footerRereshing;
//之类重载时必须先调用super
- (void)headerRereshing;

//一般结束刷新时调用该方法
- (void)endRefresh;
//结束加载更多，并且没有更多数据时调用该方法
- (void)endFooterRefreshNoMoreData;

@end
