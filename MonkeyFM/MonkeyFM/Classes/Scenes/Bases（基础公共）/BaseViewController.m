//
//  BaseViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"
#import "DrawerViewController.h"
#import "RecommendViewController.h"
#import "SWRevealViewController.h"
#import "SmallTools.h"

#define kLeftItemSize(x,y) CGSizeMake(x, y)
#define kRightItemSize(x,y) CGSizeMake(x, y)

@interface BaseViewController ()
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) DrawerViewController *drawerViewController;
@property (nonatomic, assign) CGPoint panGestureStartLocation;
@property (nonatomic, strong) RecommendViewController *recommendViewController;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor blueColor];
    //设置NavigationItem背景图片
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(drawerListAction:) ];
    // 夜间模式相关
    [self.view NightWithType:UIViewColorTypeNormal];
    // 左侧抽屉按钮
    SWRevealViewController *revealController = [self revealViewController];
    UIImage *left_list = [UIImage imageNamed:@"left_list"];  //获取图片
    CGSize itemSize = kLeftItemSize(30, 30);
    left_list = [SmallTools scaleToSize:left_list size:itemSize]; //设置图片的大小与Navigation Bar相同
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:left_list style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    // 右侧播放按钮
//    UIImage *right_play = [ThemeManage shareThemeManage].isNight ? [UIImage imageNamed:@"yejian"] : [UIImage imageNamed:@"rijian"];
//    CGSize rightItemSize = kRightItemSize(30, 30);
//    right_play = [SmallTools scaleToSize:right_play size:rightItemSize];
//    UIImage *barButtonImage = [ThemeManage shareThemeManage].isNight ? [UIImage imageNamed:@"yejian"] : [UIImage imageNamed:@"rijian"];
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:right_play style:UIBarButtonItemStylePlain target:self action:@selector(currentPlayDetail:)];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
// 跳转当前播放详情页面
- (void)currentPlayDetail:(UIBarButtonItem *)barButton
{
//    [ThemeManage shareThemeManage].isNight = ![ThemeManage shareThemeManage].isNight;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
//    [[NSUserDefaults standardUserDefaults] setBool:[ThemeManage shareThemeManage].isNight forKey:@"night"];
//    UIImage *barButtonImage = [ThemeManage shareThemeManage].isNight ? [UIImage imageNamed:@"yejian"] : [UIImage imageNamed:@"rijian"];
//    [barButton setImage:barButtonImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
// 点击弹出抽屉列表
//- (void)drawerListAction:(id)sender
//{
//    
//}


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
