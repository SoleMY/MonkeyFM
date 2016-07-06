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
@interface RegistViewController ()
/// 电话号
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

/// 验证码
@property (weak, nonatomic) IBOutlet UITextField *verification;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)VerificationButton:(UIButton *)sender {
    
  
        
        [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneNum.text callback:^(BOOL succeeded, NSError *error) {
            // 发送失败可以查看 error 里面提供的信息
          
            if (succeeded) {
                 [self setHUDWithTitle:@"发送成功"];
            } else {
                 [self setHUDWithTitle:@"手机号输入有误"];
                  NSLog(@"%@", error);
            }
            
        }];
    
    
}

- (IBAction)NextButton:(id)sender {
    
    __weak typeof(self) myself = self;
      if (self.phoneNum.text.length == 11 && self.verification.text.length > 1) {
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:self.phoneNum.text smsCode:self.verification.text block:^(AVUser *user, NSError *error) {
       
        
        [self setHUDWithTitle:@"注册成功"];
        [myself dismissViewControllerAnimated:YES completion:nil];
        
    }];
          
      } else {
           
          [self setHUDWithTitle:@"手机号输入有误"];

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
- (IBAction)backButton:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)emailPushButton:(UIButton *)sender {
    LastRegistViewController *last = [[LastRegistViewController alloc] init];
    [self presentViewController:last animated:YES completion:nil];
    
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
