//
//  BaseNavigationController.m
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/14.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController ()

@property (weak, nonatomic) id currentController;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
   
    
}

@end
