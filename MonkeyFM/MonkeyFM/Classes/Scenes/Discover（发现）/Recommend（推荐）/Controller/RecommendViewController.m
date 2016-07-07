//
//  RecommendViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RecommendViewController.h"
#import "SWRevealViewController.h"
#import "Request.h"
#import "TodayWillListen.h"
#define kLeftItemSize(x,y) CGSizeMake(x, y)
@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐";
    
    SWRevealViewController *revealController = [self revealViewController];
    

    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    // +++++++++++++++++++++++++++++++++++++
    
    // 设置头视图
    [self setHeaderView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TodayWillListen class] forCellReuseIdentifier:@"Today"];
}

// 设置头视图
- (void)setHeaderView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    view.backgroundColor = [UIColor yellowColor];
    
    Request *request = [[Request alloc] init];
    [request requestWithURL:kRecommend_Pic_URL view:view frame:view.frame];

    self.tableView.tableHeaderView = view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodayWillListen *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Today" forIndexPath:indexPath];
//    cell.textLabel.text = @"qwe";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
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
