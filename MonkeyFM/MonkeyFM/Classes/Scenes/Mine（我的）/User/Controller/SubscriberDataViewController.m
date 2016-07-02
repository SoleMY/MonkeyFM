//
//  SubscriberDataViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SubscriberDataViewController.h"

@interface SubscriberDataViewController ()

@end

@implementation SubscriberDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    // title
    self.title = @"用户资料";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}

- (void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
