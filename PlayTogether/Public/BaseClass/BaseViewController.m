//
//  BaseViewController.m
//  Tuchu
//
//  Created by Lingday on 15/4/20.
//  Copyright (c) 2015年 Lingday. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

NSString *const HadLoginAtAnotherPlaceNotification = @"HadLoginAtAnotherPlaceNotification";
NSString *const HadPresentedKey = @"HadPresentedKey";

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *resultMessageLabel;

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(NSMutableArray *)infoDataArray
{
    if (!_infoDataArray ) {
        _infoDataArray =_infoDataArray =[[NSMutableArray alloc]init];
    }
    return _infoDataArray;
}

#pragma clang diagnositic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    backItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.navigationItem.leftBarButtonItem = backItem;
    self.leftBarButtonItem = backItem;
    
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 20)] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.rightBarButtonItem = rightItem;
        
    [self.view addSubview:self.resultMessageLabel];
    
    

}

#pragma clang diagnostic pop



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

#pragma mark - method can override by son class

-(void)leftAction
{
    DDLog(@"left Action");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction
{
    
}

- (UIColor*)navigaitonBarBackgroundColor
{
    return [UIColor colorWithHex:0x3A4B76];
}

- (NSDictionary*)navigationBarTitleTextAttribute
{
    return @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endRefresh
{
    
}

#pragma mark - Public method for control resultMessageLabel

- (void)resultMessageHidden:(BOOL)hidden
{
    self.resultMessageLabel.hidden = hidden;
    if (hidden) {
        [self.view sendSubviewToBack:self.resultMessageLabel];
    }else{
        [self.view bringSubviewToFront:self.resultMessageLabel];
    }
}

- (void)resetResultMessageFrame:(CGRect)frame
{
    self.resultMessageLabel.frame = frame;
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


}

#pragma mark - getter

- (UILabel *)resultMessageLabel
{
    if (_resultMessageLabel == nil) {
        _resultMessageLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
        _resultMessageLabel.textAlignment = NSTextAlignmentCenter;
        _resultMessageLabel.textColor = [UIColor lightGrayColor];
        _resultMessageLabel.font = [UIFont systemFontOfSize:30];
        _resultMessageLabel.text = @"无结果";
        _resultMessageLabel.hidden = YES;
    }
    return _resultMessageLabel;
}

- (BOOL)isNetworkReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


@end
