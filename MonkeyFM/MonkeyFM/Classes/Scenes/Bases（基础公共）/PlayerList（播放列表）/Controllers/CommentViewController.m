//
//  CommentViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import <NinaPagerView.h>
#import "NetWorking.h"
#import "SingleList.h"
#import "PlayList.h"
#import "MJRefresh.h"
#import "SmallTools.h"

@interface CommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, assign)NSInteger number;

@property (nonatomic, strong)NSMutableArray *allDataArray;

@property (nonatomic, assign)CGFloat height;

@end

@implementation CommentViewController

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
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"cell"];
    self.number = 1;
    [self.tableView NightWithType:UIViewColorTypeNormal];
    [self request];
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)request {
    NSString *uid = [[SingleList shareSingleList].dict objectForKey:@"ID"];
    NSString *URLStr =[NSString stringWithFormat:@"%@%@%@%ld%@", PLAY_LIST_COMMENT_BASEURL, uid, PLAY_LIST_COMMENT_APPENDONE, (long)self.number, PLAY_LIST_COMMENT_APPENDTWO];
    NetWorking *netWork = [[NetWorking alloc] init];
    __weak typeof(self)weakSelf = self;
    [netWork requestWithURL:URLStr Bolck:^(id array) {
        NSDictionary *dict = array[@"result"];
        NSArray *dataList = dict[@"dataList"];
        for (NSDictionary *dic in dataList) {
            PlayList *playList = [[PlayList alloc] init];
            [playList setValuesForKeysWithDictionary:dic];
            [weakSelf.allDataArray addObject:playList];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell NightWithType:UIViewColorTypeNormal];
    [cell bindWithModel:self.allDataArray[indexPath.row]];
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
    PlayList *playList = self.allDataArray[indexPath.row];
  self.height = [SmallTools FramWithtextHeightWithText:playList.content font:[UIFont systemFontOfSize:17]];
    return self.height + 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
