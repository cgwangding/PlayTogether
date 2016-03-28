

//
//  UIViewController+RefreshExtension.m
//  AlarmPolice
//
//  Created by AD-iOS on 15/12/1.
//  Copyright © 2015年 Adinnet. All rights reserved.
//

#import "UIViewController+RefreshExtension.h"

static const NSString * const ScrollViewKey = @"ScrollViewKey";

@interface UIViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation UIViewController (RefreshExtension)

- (void)addALLRefreshWithScrollView:(UIScrollView*)scrollView
{
    [self addHeaderRefreshWithScrollView:scrollView];
    [self addFootrerRefreshWithScrollView:scrollView];
}
- (void)addHeaderRefreshWithScrollView:(UIScrollView*)scrollView
{
    self.scrollView = scrollView;
    scrollView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    scrollView.mj_header.automaticallyChangeAlpha = YES;

}
- (void)addFootrerRefreshWithScrollView:(UIScrollView*)scrollView
{
    self.scrollView = scrollView;
    scrollView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    scrollView.mj_footer.automaticallyChangeAlpha= YES;

}

- (void)footerRereshing
{

}
- (void)headerRereshing
{
    if (self.scrollView.mj_footer) {
        [self.scrollView.mj_footer resetNoMoreData];
    }
}

- (void)endRefresh
{
    if (self.scrollView.mj_footer.isRefreshing) {
        [self.scrollView.mj_footer endRefreshing];
    }
    if (self.scrollView.mj_header.isRefreshing) {
        [self.scrollView.mj_header endRefreshing];
    }
    
}

- (void)endFooterRefreshNoMoreData
{
    if (self.scrollView.mj_footer && self.scrollView.mj_footer.isRefreshing) {
        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - getter & setter 

- (UIScrollView *)scrollView
{
    return objc_getAssociatedObject(self, &ScrollViewKey);
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    objc_setAssociatedObject(self, &ScrollViewKey, scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
