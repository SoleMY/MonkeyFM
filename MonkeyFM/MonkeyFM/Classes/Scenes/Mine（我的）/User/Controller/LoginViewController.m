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
@interface LoginViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *wechat;
@property (weak, nonatomic) IBOutlet UIImageView *qq;
@property (weak, nonatomic) IBOutlet UIImageView *weibo;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // title
    self.title = @"登录";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    // 失败的渲染
//    [self.backImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.backImageView.backgroundColor = [UIColor colorWithRed:46/255.0 green:196/255.0 blue:96/255.0 alpha:1];
    
    [self addGesture];
    
}

- (void)addGesture
{
    UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQQ:)];
    // 设置轻拍次数
    aTapGR.numberOfTapsRequired = 1;
    
    aTapGR.delegate = self;
    // 设置手指触摸的个数
//    aTapGR.numberOfTouchesRequired = 2;
    
    // 添加手势
    [self.qq addGestureRecognizer:aTapGR];
    
}


- (void)tapQQ:(UIGestureRecognizer *)sender
{
    NSLog(@"点我");
}

- (IBAction)BackButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 登录button
- (IBAction)loginButton:(UIButton *)sender {
    
    // 用户查询
//    AVQuery *userQuery = [AVQuery queryWithClassName:self.nickName.text];
    
    __weak typeof(self) mySelf = self;
    [AVUser logInWithUsernameInBackground:self.nickName.text password:self.password.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登陆成功");
            [mySelf dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    // 手机号登录
//    [AVUser logInWithMobilePhoneNumberInBackground:@"13577778888" password:@"cat!@#123" block:^(AVUser *user, NSError *error) {
//        
//    }];
    
}

// 注册按钮的点击事件
- (IBAction)registButton:(id)sender {
    
    RegistViewController *regist = [[RegistViewController alloc] init];
    
    [self presentViewController:regist animated:YES completion:nil];
    
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
