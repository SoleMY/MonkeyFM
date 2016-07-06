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
    NSLog(@"qq");
}


// 微信
- (void)tapWechat:(UIGestureRecognizer *)sender
{
    NSLog(@"weChat");
}

// 微博
- (void)tapWeibo:(UIGestureRecognizer *)sender
{
    NSLog(@"微博");

}


- (IBAction)BackButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 登录button
- (IBAction)loginButton:(UIButton *)sender {
    
    // 用户查询
    
    __weak typeof(self) mySelf = self;
    [AVUser logInWithUsernameInBackground:self.nickName.text password:self.password.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登陆成功");
            [mySelf dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            NSLog(@"%@", error);
        }
    }];
    

    
}

// 注册按钮的点击事件
- (IBAction)registButton:(id)sender {
    
    RegistViewController *regist = [[RegistViewController alloc] init];
    
    [self presentViewController:regist animated:YES completion:nil];
    
}
- (IBAction)findPassword:(UIButton *)sender {
    RetrievePassword *retrieve = [[RetrievePassword alloc] init];
    [self presentViewController:retrieve animated:YES completion:nil];
    
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
