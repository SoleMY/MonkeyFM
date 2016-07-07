//
//  BaseNavigationViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseNavigationViewController.h"
#define kNavigationTintColor [UIColor whiteColor]

@interface BaseNavigationViewController ()



@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航栏的背景颜色
//    self.navigationBar.barTintColor = kNavigationBarTintColor;
    // 导航栏元素颜色
    
    [self.navigationBar NightWithType:UIViewColorTypeNormal];
    self.navigationBar.tintColor = kNavigationTintColor;
    
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
