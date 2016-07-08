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
#import "TodayModel.h"
#import "PopularItemTableViewCell.h"
#import "DetailClassificationViewController.h"
#define kLeftItemSize(x,y) CGSizeMake(x, y)
@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *allInfoRecommendDictionary;

@property (nonatomic, strong) NSMutableArray *todayArray;

@property (nonatomic, assign) NSInteger index;

@end

@implementation RecommendViewController


- (NSMutableDictionary *)allInfoRecommendDictionary
{
    if (!_allInfoRecommendDictionary) {
        _allInfoRecommendDictionary = [NSMutableDictionary dictionary];
    }
    return _allInfoRecommendDictionary;
}

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
    [self.tableView registerClass:[PopularItemTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 解析数据
//    [self requstToday];
}

- (void)viewWillAppear:(BOOL)animated
{
    // 解析数据
    self.index = 0;
    [self requstToday];
}

//static NSInteger j = 0;
- (void)requstToday
{
//   static NSInteger j = 0;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:kRecommend_Pic_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"result"];
        
        NSArray *listArray = [dict objectForKey:@"dataList"];
        for (NSInteger i = 0; i < listArray.count; i++) {
            
            NSDictionary *oneObject = listArray[i];
            
            NSArray *allDataArray = oneObject[@"dataList"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in allDataArray) {
                
                TodayModel *today = [[TodayModel alloc] init];
               
                [today setValuesForKeysWithDictionary:dic];
                
                
                [mArr addObject:today];
                
            }
            if (i > 2 && i != 4 && i != 5 && i != 6 && i != 7 && i != 9 && i != 10 && i != 12 && i != 11 && i != 15 && i != 16) {
                
                [self.allInfoRecommendDictionary setValue:mArr forKey:[NSString stringWithFormat:@"%ld", self.index]];
                self.index++;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 设置头视图
- (void)setHeaderView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
//    view.backgroundColor = [UIColor yellowColor];
    
    Request *request = [[Request alloc] init];
    [request requestWithURL:kRecommend_Pic_URL view:view frame:view.frame];

    self.tableView.tableHeaderView = view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allInfoRecommendDictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [[self.allInfoRecommendDictionary objectForKey:[NSString stringWithFormat:@"%ld", section]] count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    TodayWillListen *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Today" forIndexPath:indexPath];
    cell.albumBlock = ^(){
        
        
        
    };
    NSArray *arr = [self.allInfoRecommendDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section]];
    cell.albumArr = arr.mutableCopy;


    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
//    nameLabel.text = @"今日必听";
       UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 0, 50, 30);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [view addSubview:nameLabel];
    [view addSubview:button];
    
    [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  

    //
    switch (section) {
        case 0:
            nameLabel.text = @"今日必听";
            [button removeFromSuperview];
            break;
        case 1:
            nameLabel.text = @"电台精选";
            break;
        case 2:
            nameLabel.text = @"搞笑段子";
            break;
        case 3:
            nameLabel.text = @"热度新闻";
            break;
        case 4:
            nameLabel.text = @"情感倾诉";
            break;
        case 5:
            nameLabel.text = @"逗咖相声";
            break;
        case 6:
            nameLabel.text = @"育儿亲子";
            break;
        case 7:
            nameLabel.text = @"军事热点";
            break;
        case 8:
            nameLabel.text = @"听音乐";
            break;
    }
    //

    view.backgroundColor = kNavigationBarTintColor;
    view.alpha = 0.7;
    
    return view;
}

- (void)clickButtonAction:(UIButton *)sender
{
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//        return self.title = @"今日必听";
//            break;
//        case 1:
//            return self.title = @"电台精选";
//            break;
//        case 2:
//            return self.title = @"搞笑段子";
//            break;
//        case 3:
//            return self.title = @"热度新闻";
//            break;
//        case 4:
//            return self.title = @"情感倾诉";
//            break;
//        case 5:
//            return self.title = @"逗咖相声";
//            break;
//        case 6:
//            return self.title = @"育儿亲子";
//            break;
//        case 7:
//            return self.title = @"军事热点";
//            break;
//        case 8:
//            return self.title = @"听音乐";
//            break;
//    }
//
//    return self.title;
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
