//
//  LoginViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "LoginViewController.h"
#import "AVOSCloud/AVOSCloud.h"
#import "RegistViewController.h"
#import "MineViewController.h"
#import "RetrievePassword.h"
#import "UMSocial.h"
#import "BaseNavigationViewController.h"
@interface LoginViewController ()<UIGestureRecognizerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *wechat;
@property (weak, nonatomic) IBOutlet UIImageView *qq;
@property (weak, nonatomic) IBOutlet UIImageView *weibo;

// 三个button属性
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *RetrievePassword;

@end



@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.backImageView.backgroundColor = kNavigationBarTintColor;
    
    [self addGesture];
    
    [self.loginButton setTitleColor:kNavigationBarTintColor forState:UIControlStateNormal];
    [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.RetrievePassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.nickName.delegate = self;
    [self.nickName becomeFirstResponder];
    self.password.delegate = self;
    [self.nickName becomeFirstResponder];
}

// 当点击键盘return的时候
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nickName resignFirstResponder]; // 释放第一响应者
    [self.password resignFirstResponder];
    return YES;
}
//  触摸屏幕回收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)addGesture
{
    
    self.qq.userInteractionEnabled = YES;
    UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQQ:)];
    // 设置轻拍次数
    aTapGR.numberOfTapsRequired = 1;
    
    aTapGR.delegate = self;
    
    // 添加手势
    [self.qq addGestureRecognizer:aTapGR];
    
    // 微信
    self.wechat.userInteractionEnabled = YES;
    UITapGestureRecognizer *aTapWechat = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWechat:)];
    // 设置轻拍次数
    aTapWechat.numberOfTapsRequired = 1;
    
    aTapWechat.delegate = self;
    
    // 添加手势
    [self.wechat addGestureRecognizer:aTapWechat];
    
    // 微信
    self.weibo.userInteractionEnabled = YES;
    UITapGestureRecognizer *aTapWeiBo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWeibo:)];
    // 设置轻拍次数
    aTapWeiBo.numberOfTapsRequired = 1;
    
    aTapWeiBo.delegate = self;
    
    // 添加手势
    [self.weibo addGestureRecognizer:aTapWeiBo];
    
}

// qq
- (void)tapQQ:(UIGestureRecognizer *)sender
{

}


// 微信
- (void)tapWechat:(UIGestureRecognizer *)sender
{
    
}

// 微博
- (void)tapWeibo:(UIGestureRecognizer *)sender
{

}


// 找回密码
- (IBAction)retrievePassword:(UIButton *)sender {
    RetrievePassword *retrieve = [[RetrievePassword alloc] init];
    [self.navigationController pushViewController:retrieve animated:YES];
}

- (IBAction)BackButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// 登录button
- (IBAction)loginButton:(UIButton *)sender {

    __weak typeof(self) mySelf = self;
    [AVUser logInWithUsernameInBackground:self.nickName.text password:self.password.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self setHUDWithTitle:@"登陆成功"];
            [mySelf.navigationController popViewControllerAnimated:YES];
            
        } else {
            [AVUser logInWithMobilePhoneNumberInBackground:self.nickName.text password:self.password.text block:^(AVUser *user, NSError *error) {
                if (user != nil) {
                    [self setHUDWithTitle:@"登陆成功"];
                    MineViewController *mine = [[MineViewController alloc] init];
                    [mySelf.navigationController pushViewController:mine animated:YES];
                } else {
                    NSLog(@"error = %@", error);
                    if (error.code == 1) {
                        [self setHUDWithTitle:@"登录失败次数超过限制，请稍候再试"];
                    } else if (error.code == 201) {
                        [self setHUDWithTitle:@"用户名或密码错误"];
                    } else if (error.code == 211 || error.code == 213) {
                        [self setHUDWithTitle:@"用户名或手机号不存在"];
                    }
                }
                
            }];
        }
    }];
    
}

- (void)setHUDWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 5.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

// 注册按钮的点击事件
- (IBAction)registButton:(id)sender {
    
    RegistViewController *regist = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
