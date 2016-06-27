//
//  HostViewController.m
//  MonkeyFM
//
//  Created by 郑淮予 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HostViewController.h"
#import "MJRefresh.h"
#import "HostViewDetaileCell.h"
#import <AFNetworking.h>
#import "MFM_URL.h"
#import "NetWorking.h"
#import "More.h"
#import <UIImageView+WebCache.h>
#import "HostInfoViewController.h"

@interface HostViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *allDataArray;

@property (nonatomic, strong)NSArray *appandingArray;

@end

@implementation HostViewController

- (NSMutableArray *)allDataArray {
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.view = self.tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestWithPage:@"1"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[HostViewDetaileCell class] forCellReuseIdentifier:@"cell"];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestWithPage:@"1"];
        [self.tableView.mj_header endRefreshing];

    }];
}

- (void)requestWithPage:(NSString *)page  {
    self.appandingArray = [self.appendString componentsSeparatedByString:@"&"];
    NSString *URLStr = [NSString stringWithFormat:@"%@&%@&%@&pagenum=%@", self.appandingArray[0], self.appandingArray[1], self.appandingArray[2], page];
    NSString *str = [NSString stringWithFormat:@"%@%@%@", Host_Base_URL, URLStr, Host_append_URL];
    NetWorking *netWorking =[[NetWorking alloc] init];
    [netWorking requestWithURL:str Bolck:^(id array) {
        NSDictionary *resultDic = [array objectForKey:@"result"];
        NSArray *dataList = [resultDic objectForKey:@"dataList"];
        for (NSDictionary *dic in dataList) {
            More *more=  [[More alloc] init];
            [more setValuesForKeysWithDictionary:dic];
            [self.allDataArray addObject:more];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}




- (void)back:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%ld", self.allDataArray.count);
    return self.allDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HostViewDetaileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    More *more = self.allDataArray[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:more.avatar]];
    cell.nameLabel.text = more.nickName;
    cell.decLabel.text = more.desc;
    cell.fansNumber.text = [NSString stringWithFormat:@"粉丝数：%ld", more.fansCount];
    if (indexPath.row == self.allDataArray.count - 1) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self requestWithPage:[NSString stringWithFormat:@"%ld", indexPath.row / 20 + 2]];
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer endRefreshing];
        }];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HostInfoViewController *hostInfoVC = [[HostInfoViewController alloc] init];
//    传值 uid
    More *more = self.allDataArray[indexPath.row];
    hostInfoVC.uid = more.uid;
    [self.navigationController pushViewController:hostInfoVC animated:YES];
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
