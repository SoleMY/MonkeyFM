//
//  RadioPlayerListViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioPlayerListViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

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
    self.navigationController.navigationBar.translucent = NO;
    [self setSegmented];
    [self setSmallSegmentedControl];
    // 设置导航栏的segmented
    
//    [self setNavigationSegmented:self.navigationSegmented];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_anchor_back@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(popBackController)];
    
    
}

- (void)setSmallSegmentedControl
{
    if (_segmentedStyle == Type) {
        //设置数据源
        // 在改变显示的视图之前，先移除数组内数据和视图上所有的子视图
        [self.menuArray removeAllObjects];
        [self.tableArray removeAllObjects];
        [self removeAllSubViews];
        self.menuArray = [NSMutableArray arrayWithArray:@[@"国家台",@"省市台",@"网络台"]];
        self.tableArray = [NSMutableArray arrayWithCapacity:self.menuArray.count];
        for (NSString *title in self.menuArray) {
            MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            table.title = title;
            [self.tableArray addObject:table];
        }
        
        //设置控件位置
        self.menuframe = CGRectMake(0, 0, ScreenW, 20);
        self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), ScreenW, ScreenH - CGRectGetMaxY(self.menuframe));
        
        //调用父类方法加载控件
        [super viewDidLoad]; //最后执行
        NSLog(@"content = %ld", self.tableArray.count);
        
    } else if (_segmentedStyle == Content) {
        [self.menuArray removeAllObjects];
        [self.tableArray removeAllObjects];
        [self removeAllSubViews];
        //设置数据源
        self.menuArray = [NSMutableArray arrayWithArray:@[@"推荐",@"热点",@"科技",@"体育",@"视频",@"要闻",@"时政",@"美女",@"搞笑",@"娱乐"]];
        self.tableArray = [NSMutableArray arrayWithCapacity:self.menuArray.count];
        for (NSString *title in self.menuArray) {
            MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            table.title = title;
            [self.tableArray addObject:table];
        }
        
        //设置控件位置
        self.menuframe = CGRectMake(0, 0, ScreenW, 20);
        self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), ScreenW, ScreenH - CGRectGetMaxY(self.menuframe));
        
        //调用父类方法加载控件
        [super viewDidLoad]; //最后执行
        NSLog(@"content = %ld", self.tableArray.count);
    }
}
- (void)removeAllSubViews
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    for(UIView *view in [self.view subviews])
    //    {
    //        [view removeFromSuperview];
    //    }
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
    
}

- (void)indexDidChangeForSegmentedControl:(id)sender
{
    NSInteger index = self.navigationSegmented.selectedSegmentIndex;
    if (index == 0) {
        self.segmentedStyle = Type;
        [self setSmallSegmentedControl];
    } else {
        self.segmentedStyle = Content;
        [self setSmallSegmentedControl];
    }

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
