//
//  RadioPlayerListViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioPlayerListViewController.h"
#import "MFM_Tool_COLOR.h"

typedef NS_ENUM(NSUInteger, SegmentedStyle) {
    Type,
    Content,
};
@interface RadioPlayerListViewController ()

@property (nonatomic, strong) UISegmentedControl *navigationSegmented;

@property (nonatomic, assign) SegmentedStyle segmentedStyle;

@end

@implementation RadioPlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSegmented];
    // 设置导航栏的segmented
    
//    [self setNavigationSegmented:self.navigationSegmented];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_anchor_back@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(popBackController)];
    
    
}
- (void)setSegmented
{
    self.navigationSegmented = [[UISegmentedControl alloc] initWithItems:@[@"类型", @"内容"]];
    // 设置属性
    self.navigationSegmented.backgroundColor = [UIColor whiteColor];
    self.navigationSegmented.frame = CGRectMake(0, 0, 200, 30);
    
    self.navigationSegmented.layer.cornerRadius = 5;
    self.navigationSegmented.layer.masksToBounds = YES;
    // 指定被选中的分段
    self.navigationSegmented.selectedSegmentIndex = 0;
    self.navigationSegmented.tintColor = kNavigationBarTintColor;
    [self.navigationSegmented addTarget:self  action:@selector(indexDidChangeForSegmentedControl:)
                       forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:self.navigationSegmented];
    NSInteger index = self.navigationSegmented.selectedSegmentIndex;
    if (index == 0) {
        self.segmentedStyle = Type;
    } else {
        self.segmentedStyle = Content;
    }
}

- (void)indexDidChangeForSegmentedControl:(id)sender
{
    
}

- (void)popBackController
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
