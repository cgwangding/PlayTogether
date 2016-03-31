//
//  PTLoginViewController.m
//  PlayTogether
//
//  Created by AD-iOS on 16/3/28.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "PTLoginViewController.h"

@interface PTLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTF;
- (IBAction)loginButtonClicked:(id)sender;

@end

@implementation PTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonClicked:(id)sender {
    
    BmobQuery *query = [BmobUser query];
    //检查是否注册
    [query whereKey:@"username" equalTo:self.userNameTF.text];
    WEAKSELF
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        STRONGSELF
        if (!error) {
            if (number > 0) {
                [strongSelf login];
            }else{
                [SVProgressHUD showInfoWithStatus:@"请先注册"];
            }
        }else{
            [strongSelf login];
        }
    }];
}

- (void)login{
    
    [BmobUser loginInbackgroundWithAccount:self.userNameTF.text andPassword:self.userPwdTF.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            BmobUser *bUser = [BmobUser getCurrentUser];
            //更新number为30
            [bUser setObject:UUID forKey:@"uuid"];
            WEAKSELF
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                STRONGSELF
                if (isSuccessful) {
                    [SVProgressHUD showInfoWithStatus:@"登录成功"];
                    strongSelf.navigationController.navigationBarHidden = YES;
                    [strongSelf performSegueWithIdentifier:@"loginIdentifier" sender:nil];
                }else{
                    DDLog(@"error %@",[error description]);
                }
            }];
        } else{
            [SVProgressHUD showInfoWithStatus:@"登录失败"];
            DDLog(@"login failed>>>%@",error);
        }
    }];
}

@end
