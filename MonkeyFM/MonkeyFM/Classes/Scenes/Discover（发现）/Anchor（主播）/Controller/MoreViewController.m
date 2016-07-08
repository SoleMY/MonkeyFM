//
//  MoreViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "NetWorking.h"
#import "More.h"
#import "PlayListViewController.h"
#import "SingleList.h"
#import "MJRefresh.h"

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *allDataArr;

@end

@implementation MoreViewController

- (NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray array];
    }
    return _allDataArr;
}

- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    [self.tableView registerClass:[MoreCell class] forCellReuseIdentifier:@"MoreCell"];
    [self request];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    [self.tableView NightWithType:UIViewColorTypeNormal];
    
}

- (void)request{
    NetWorking *netWorking = [[NetWorking alloc] init];
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@%@%@", Host_detaile_BaseURL, self.appendStr, Host_detaile_AppendURLOne, self.uid, Host_detaile_AppendURLTwo];
    __weak typeof(self)weakSelf = self;
    [netWorking requestWithURL:URLString Bolck:^(id array) {
        NSDictionary *resultDic = array[@"result"];
        NSArray *dataListArr = resultDic[@"dataList"];
        for (NSDictionary *dict in dataListArr) {
            More *more = [[More alloc] init];
            [more setValuesForKeysWithDictionary:dict];
            [weakSelf.allDataArr addObject:more];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    }];
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    [cell NightWithType:UIViewColorTypeNormal];
    
    More *more = self.allDataArr[indexPath.row];
    if ([self.appendStr isEqualToString:@"subscribe"]) {
        [cell.picture sd_setImageWithURL:[NSURL URLWithString: more.pic]];
        cell.titleLabel.text = more.name;
        cell.subLabel.text = more.desc;
    } else if ([self.appendStr isEqualToString:@"like"]) {
        [cell.picture sd_setImageWithURL:[NSURL URLWithString:more.audioPic]];
        cell.titleLabel.text = more.audioName;
        cell.subLabel.text = more.albumName;
        
    } else{
        [cell.picture sd_setImageWithURL:[NSURL URLWithString: more.pic]];
        cell.titleLabel.text = more.name;
        cell.subLabel.text = more.NewTitle;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayListViewController *PlayListVC = [[PlayListViewController alloc] init];
     More *more = self.allDataArr[indexPath.row];
    [[SingleList shareSingleList].dict setObject:more.Id forKey:@"ID"];
    [self.navigationController pushViewController:PlayListVC animated:YES];
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
