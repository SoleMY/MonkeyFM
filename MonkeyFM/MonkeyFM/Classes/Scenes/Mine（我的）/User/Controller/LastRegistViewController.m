//
//  LastRegistViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "LastRegistViewController.h"
#import "AVOSCloud/AVOSCloud.h"
#import "LoginViewController.h"
@interface LastRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@end

@implementation LastRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registeButton:(id)sender {
    AVUser *user = [AVUser user]; // 新建 AVUser 对象实例
    user.username = self.nickname.text; // 设置用户名
    user.password =  self.password.text; // 设置密码
    user.email = self.email.text; // 设置邮箱
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            LoginViewController *login = [[LoginViewController alloc] init];
            login.nickName.text = self.nickname.text;
            login.headerImage = self.headerImage;
            [self presentViewController:login animated:YES completion:nil];
            
            
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
        }
    }];
    
    
}
- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)tapGesture:(id)sender {
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
