//
//  BaseNavigationViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseNavigationViewController.h"
#define kNavigationBarTintColor [UIColor colorWithRed:(70/255.0) green:(184 / 255.0) blue:(113 / 255.0) alpha:1]
#define kNavigationTintColor [UIColor whiteColor]

@interface BaseNavigationViewController ()<UISearchBarDelegate>



@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 给所有的导航栏添加搜索栏
    CGRect mainViewBounds = self.view.bounds;
    self.customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 30, mainViewBounds.size.width - 120, 20)];
    self.customSearchBar.delegate = self;
    self.customSearchBar.showsCancelButton = NO;
    [self.view addSubview:self.customSearchBar];
    // 导航栏的背景颜色
    self.navigationBar.barTintColor = kNavigationBarTintColor;
    // 导航栏元素颜色
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
