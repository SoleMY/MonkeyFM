//
//  RetrievePassword.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/5.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RetrievePassword.h"
#import "AVOSCloud/AVOSCloud.h"
@interface RetrievePassword ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *VerificationCode;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *mima2;
@property (weak, nonatomic) IBOutlet UIButton *verification;
@property (weak, nonatomic) IBOutlet UIButton *retrieve;

@end

@implementation RetrievePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找回密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    // 设置颜色和圆角
    [self setShape];
    
    // 键盘
    self.telTextField.delegate = self;
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.telTextField becomeFirstResponder];
    
    self.VerificationCode.delegate = self;
    self.VerificationCode.keyboardType = UIKeyboardTypeNumberPad;
    [self.VerificationCode becomeFirstResponder];
    
    self.mima.delegate = self;
    [self.mima becomeFirstResponder];
    self.mima2.delegate = self;
    [self.mima2 becomeFirstResponder];
    [self.view NightWithType:UIViewColorTypeNormal];
}

// 当点击键盘return的时候
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.telTextField resignFirstResponder];
    [self.VerificationCode resignFirstResponder];
    [self.mima resignFirstResponder];
    [self.mima2 resignFirstResponder];
    return YES;
}

//  触摸屏幕回收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setShape {
    // 电话号textField
    self.telTextField.layer.cornerRadius = 10;
    self.telTextField.layer.borderWidth = 1;
    self.telTextField.layer.borderColor = kNavigationBarTintColor.CGColor;
    // 验证码textField
    self.VerificationCode.layer.cornerRadius = 10;
    self.VerificationCode.layer.borderWidth = 1;
    self.VerificationCode.layer.borderColor = kNavigationBarTintColor.CGColor;
    // 密码
    self.mima.layer.cornerRadius = 10;
    self.mima.layer.borderWidth = 1;
    self.mima.layer.borderColor = kNavigationBarTintColor.CGColor;
    // 重新输入
    self.mima2.layer.cornerRadius = 10;
    self.mima2.layer.borderWidth = 1;
    self.mima2.layer.borderColor = kNavigationBarTintColor.CGColor;
    // 验证码button
    self.verification.layer.cornerRadius = 10;
    self.verification.layer.borderWidth = 1;
    self.verification.layer.borderColor = kNavigationBarTintColor.CGColor;
    self.verification.backgroundColor = kNavigationBarTintColor;
    [self.verification setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 找回button
    self.retrieve.layer.cornerRadius = 10;
    self.retrieve.layer.borderWidth = 1;
    self.retrieve.layer.borderColor = [UIColor whiteColor].CGColor;
    self.retrieve.backgroundColor = kNavigationBarTintColor;
    [self.retrieve setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)VerificationCode:(id)sender {
    [AVUser requestPasswordResetWithPhoneNumber:self.telTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self setHUDWithTitle:@"成功发送验证码"];
        } else {
            if (error.code == 212) {
                [self setHUDWithTitle:@"请指定手机号"];
            } else if (error.code == 213) {
                [self setHUDWithTitle:@"手机号未找到"];
            }
        }
    }];
    
}


- (IBAction)RetrievePasswordButton:(id)sender {
    
    
    if ([self.mima2.text isEqualToString:self.mima.text]) {
        [AVUser resetPasswordWithSmsCode:self.VerificationCode.text newPassword:self.mima.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self setHUDWithTitle:@"找回密码成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self setHUDWithTitle:@"宝宝也不知道失败原因"];
            }
        }];
    } else {
        [self setHUDWithTitle:@"两次输入不一致"];
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
