//
//  BaseTableViewController.m
//  Tuchu
//
//  Created by Lingday on 15/4/20.
//  Copyright (c) 2015年 Lingday. All rights reserved.
//

#import "BaseTableViewController.h"
#import "LoginViewController.h"
#import "PersonalCenterView.h"


@interface BaseTableViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseTableViewController
@synthesize dataArray;


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
#pragma clang diagnostic pop
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    backItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.navigationItem.leftBarButtonItem = backItem;
    self.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 20)] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.rightBarButtonItem = rightItem;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.2] size:CGSizeMake(Screen_Width, 1)]];
    
    //设置导航栏的背景颜色，不可再设置导航栏的背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[self navigaitonBarBackgroundColor] size:CGSizeMake(Screen_Width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[self navigationBarTitleTextAttribute]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shouldLoginNotification:) name:HadLoginAtAnotherPlaceNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:HadLoginAtAnotherPlaceNotification object:nil];

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.view];
    if (point.x > 10) {
        return NO;
    }
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIColor*)navigaitonBarBackgroundColor
{
    return [UIColor colorWithHex:0x3A4B76];
}

- (NSDictionary*)navigationBarTitleTextAttribute
{
    return @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
}

//右边按钮
-(void)setupNavBarWithTitle:(NSString *)title
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(rightAction)];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
}

//右边按钮的图片
- (void)setupNavBarWithimage:(NSString *)imageName
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightAction)];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
}

- (void)rightAction
{
    
}


- (BOOL)isNetworkReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


#pragma mark - notification
- (void)shouldLoginNotification:(NSNotification*)notifi{
    NSString *alarmStateInfo = [notifi object];
    NSDictionary *dict = [alarmStateInfo objectFromJSONString];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if (dict != nil && [dict isKindOfClass:[NSDictionary class]]) {
        [self.view showWithMessage:dict[@"msg"]];
        [self performSelector:@selector(presentDelay) withObject:nil afterDelay:0.75];
    }
}

- (void)presentDelay{
    default_add_Bool(YES, HadPresentedKey);
    default_synchronize;
    //退出
    [APService setAlias:[UUID substringToIndex:15] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor  clearColor] size:CGSizeMake(Screen_Width, 64)] forBarMetrics:UIBarMetricsDefault];
    [APUserData sharedUserData].online = NO;
    LoginViewController *loginVC = MainStoryBoard(@"loginIdentifier");
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
