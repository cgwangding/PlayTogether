//
//  BaseTableViewController.h
//  Tuchu
//
//  Created by Lingday on 15/4/20.
//  Copyright (c) 2015年 Lingday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface BaseTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *infoDict;

@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (assign, nonatomic) BOOL isNetworkReachable;


-(void)leftAction;
- (void)rightAction;

//子类用这个方法来改变导航栏的颜色
- (UIColor*)navigaitonBarBackgroundColor;
//子类用这个方法来改变导航栏文字的颜色
- (NSDictionary*)navigationBarTitleTextAttribute;
@end
