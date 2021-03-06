//
//  RegistViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RegistViewController.h"
#import "AVOSCloud/AVOSCloud.h"
#import "LastRegistViewController.h"
@interface RegistViewController ()<UITextFieldDelegate>
/// 电话号
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

/// 验证码
@property (weak, nonatomic) IBOutlet UITextField *verification;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 电话号输入完成时候方法
    [self.phoneNum addTarget:self action:@selector(finishWrite:) forControlEvents:UIControlEventEditingDidEnd];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    [self.view NightWithType:UIViewColorTypeNormal];
    // 设置颜色和圆角
    [self setShape];
    
    self.phoneNum.delegate = self;
    self.phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneNum becomeFirstResponder];
    
    self.verification.delegate = self;
    self.verification.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneNum becomeFirstResponder];
    
    
    
}

// 当点击键盘return的时候
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneNum resignFirstResponder]; // 释放第一响应者
    [self.verification resignFirstResponder];
    return YES;
}
//  触摸屏幕回收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setShape {
    self.phoneNum.layer.cornerRadius = 10;
    self.phoneNum.layer.borderWidth = 1;
    self.phoneNum.layer.borderColor = kNavigationBarTintColor.CGColor;
//    self.phoneNum.layer.opacity = 0.5;
    self.verification.layer.cornerRadius = 10;
    self.verification.layer.borderWidth = 1;
    self.verification.layer.borderColor = kNavigationBarTintColor.CGColor;
    //
    self.verificationButton.layer.cornerRadius = 10;
    self.verificationButton.layer.borderWidth = 1;
    self.verificationButton.layer.borderColor = kNavigationBarTintColor.CGColor;
    self.verificationButton.backgroundColor = kNavigationBarTintColor;
    [self.verificationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //
    self.registButton.layer.cornerRadius = 10;
    self.registButton.layer.borderWidth = 1;
    self.registButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.registButton.backgroundColor = kNavigationBarTintColor;
    [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
////    self.navigationController.navigationBarHidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = NO;
//}

- (void)finishWrite:(UITextField *)sender
{
    self.verificationButton.titleLabel.textColor = [UIColor cyanColor];
}

- (IBAction)VerificationButton:(UIButton *)sender {
    
  
        
        [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneNum.text callback:^(BOOL succeeded, NSError *error) {
            // 发送失败可以查看 error 里面提供的信息
            if (succeeded) {
                [self setHUDWithTitle:@"发送成功"];
            } else {
               
                NSLog(@"%@", error);
                if (error.code == 1) {
                    [self setHUDWithTitle:@"手机号输入有误"];
                } else if (error.code == 601) {
                    [self setHUDWithTitle:@"发送短信每天超出五条"];
                }
            }
        }];
    
    
}

- (IBAction)NextButton:(id)sender {
    
    __weak typeof(self) myself = self;
      if (self.phoneNum.text.length == 11 && self.verification.text.length > 1) {
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:self.phoneNum.text smsCode:self.verification.text block:^(AVUser *user, NSError *error) {
       [myself setHUDWithTitle:@"注册成功"];
        LastRegistViewController *last = [[LastRegistViewController alloc] init];
        [myself.navigationController pushViewController:last animated:YES];
    }];
          
      } else {
          [self setHUDWithTitle:@"请输入手机号"];
      }

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)backButton:(UIBarButtonItem *)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
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
