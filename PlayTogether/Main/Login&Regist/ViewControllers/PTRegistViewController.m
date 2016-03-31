//
//  PTRegistViewController.m
//  PlayTogether
//
//  Created by AD-iOS on 16/3/28.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "PTRegistViewController.h"

@interface PTRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *againPwdTF;

@property (nonatomic, assign) NSInteger reduceTime;
@property (strong, nonatomic) NSTimer *timer;

- (IBAction)registButtonClicked:(id)sender;
- (IBAction)getVerifyCodeButtonClicked:(id)sender;

@end

@implementation PTRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.timer setFireDate:[NSDate distantFuture]];
    self.reduceTime = 60;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTTP

- (void)sendSMSCode{
    __weak typeof(self) weakSelf = self;
    DLShowLoadAnimation;
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.userNameTF.text andTemplate:@"regist" resultBlock:^(int number, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        DLHideLoadAnimation;
        if (error) {
            DDLog(@"sendSMSCode>>>%@",error);
            DLShowToast(@"验证码发送失败");
        } else {
            DDLog(@"smsId:%d",number);
            DLShowToast(@"验证码已发送");
            strongSelf.getVerifyCodeButton.enabled = NO;
            [strongSelf.timer setFireDate:[NSDate date]];
        }
    }];

}

- (void)regist{
    BmobUser *buser = [[BmobUser alloc] init];
    buser.mobilePhoneNumber = self.userNameTF.text;
    buser.password = self.userPwdTF.text;
    DLShowLoadAnimation;
    [buser signUpOrLoginInbackgroundWithSMSCode:self.verifyCodeTF.text block:^(BOOL isSuccessful, NSError *error) {
        DLHideLoadAnimation;
        if (error) {
            DDLog(@"%@",error);
            DLShowToast(@"注册失败");
        } else {
            BmobUser *user = [BmobUser getCurrentUser];
            DDLog(@"%@",user);
            DLShowToast(@"注册成功，请登录");
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@YES afterDelay:0.75];
        }
    }];
}

#pragma mark - timer action
- (void)changeVerifyButtonTitle{
    if (!self.getVerifyCodeButton.enabled) {
        NSString *title = [NSString stringWithFormat:@"%lus后重发",(long)_reduceTime];
        [self.getVerifyCodeButton setTitle:title forState:UIControlStateDisabled];
        [self.getVerifyCodeButton setBackgroundColor:[UIColor lightGrayColor]];
        if (_reduceTime == 0) {
            //停止计时器
            [self.timer setFireDate:[NSDate distantFuture]];
            self.reduceTime = 60;
            self.getVerifyCodeButton.enabled = YES;
            [self.getVerifyCodeButton setBackgroundColor:APCreenColor];
        }
        _reduceTime--;
    }
    
}


#pragma mark - button action

- (IBAction)registButtonClicked:(id)sender {
    if (![self.userNameTF.text isValidateMobile]) {
        DLShowToast(@"请输入正确的手机号");
        return;
    }
    if (![self.userPwdTF.text isEqualToString:self.againPwdTF.text]) {
        DLShowToast(@"两次输入的密码不相同");
        return;
    }
    [self regist];
}

- (IBAction)getVerifyCodeButtonClicked:(id)sender {
    if ([self.userNameTF.text isValidateMobile]) {
        DDLog(@"发送验证码");
        [self sendSMSCode];
    }else{
        DLShowToast(@"请输入正确的手机号");
    }
}

#pragma mark - getter

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVerifyButtonTitle) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
