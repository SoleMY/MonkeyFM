//
//  ProgramViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ProgramViewController.h"
#import "ProgramCell.h"
#import "NetWorking.h"
#import "SingleList.h"
#import "PlayList.h"
#import "MJRefresh.h"
#import "PlayerDetailViewController.h"

@interface ProgramViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, assign)NSInteger number;

@property (nonatomic, strong)NSMutableArray *allDataArray;

@end

@implementation ProgramViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ProgramCell class] forCellReuseIdentifier:@"cell"];
    self.number = 1;
    [self request];
}

- (void)request {
    NetWorking *netWorking = [[NetWorking alloc] init];
    NSString *str = [[SingleList shareSingleList].dict objectForKey:@"ID"];
    self.URLString = [NSString stringWithFormat:@"%@%@%@%ld%@", PLAY_LIST_PROGRAM_BASEURL, str, PLAY_LIST_PROGRAM_APPEND, (long)self.number, PLAY_LIST_PROGRAM_APPENDTWO];
    NSLog( @"%@", self.URLString);
    [netWorking requestWithURL:self.URLString Bolck:^(id array) {
        NSDictionary *resultDic = array[@"result"];
        NSArray *dataList = resultDic[@"dataList"];
        for (NSDictionary *dict in dataList) {
            PlayList *playList =  [[PlayList alloc] init];
            [playList setValuesForKeysWithDictionary:dict];
            [self.allDataArray addObject:playList];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProgramCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PlayList  *playList =  self.allDataArray[indexPath.row];
    [cell bindWithModel:playList];
    if (indexPath.row == self.allDataArray.count - 1) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.number++;
            [self request];
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer endRefreshing];
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayList *playList = self.allDataArray[indexPath.row];
    PlayerDetailViewController *playerDetaileVC = [[PlayerDetailViewController alloc] init];
//    playerDetaileVC.playList = playList;
    playerDetaileVC.allDataArray = self.allDataArray;
    playerDetaileVC.row = indexPath.row;
    [self.navigationController pushViewController:playerDetaileVC animated:YES];
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
