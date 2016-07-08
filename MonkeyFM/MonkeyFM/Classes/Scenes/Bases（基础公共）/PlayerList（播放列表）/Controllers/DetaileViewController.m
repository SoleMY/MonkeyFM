//
//  DetaileViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetaileViewController.h"
#import "DetaileCell.h"
#import "KeywordsCell.h"
#import "IntroductionCell.h"
#import "AlbumDetailCell.h"
#import "NetWorking.h"
#import "SingleList.h"
#import "PlayList.h"
#import "MJRefresh.h"

@interface DetaileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, assign)NSInteger heightForCellButton;

@property (nonatomic, assign)NSInteger heightForCellText;

@property (nonatomic, strong)NSMutableArray *allDataArray;

@property (nonatomic, strong)NSMutableArray *albumArray;

//@property 

@end

@implementation DetaileViewController

- (NSMutableArray *)allDataArray {
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (NSMutableArray *)albumArray {
    if (!_albumArray) {
        _albumArray = [NSMutableArray array];
    }
    return _albumArray;
}

- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.view = self.tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[DetaileCell class] forCellReuseIdentifier:@"detaileCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[KeywordsCell class] forCellReuseIdentifier:@"keyWordCell"];
    [self.tableView registerClass:[IntroductionCell class] forCellReuseIdentifier:@"introductionCell"];
    [self.tableView registerClass:[AlbumDetailCell class] forCellReuseIdentifier:@"albumCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.albumId = [[SingleList shareSingleList].dict objectForKey:@"ID"];
    [self request];
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)request {
    NetWorking *networking = [[NetWorking alloc] init];
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@", PLAY_LIST_DETAILE_BASEURL, self.albumId, PLAY_LIST_DETAILE_APPENDURL];
    __weak typeof(self)weakSelf = self;
    [networking requestWithURL:URLString Bolck:^(id array) {
        NSDictionary *dict = array[@"result"];
        PlayList *playlist = [[PlayList alloc] init];
        [playlist setValuesForKeysWithDictionary:dict];
        [weakSelf.allDataArray addObject:playlist];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
    
   NSString *URL = [NSString stringWithFormat:@"%@%@%@", PLAY_LIST_ABOUT_BASEURL, self.albumId, PLAY_LIST_DETAILE_APPENDURL];
    [networking requestWithURL:URL Bolck:^(id array) {
        NSDictionary *result = array[@"result"];
        NSArray *dataList = result[@"dataList"];
        for (NSDictionary *dic in dataList) {
            PlayList *playList =[[PlayList alloc] init];
            [playList setValuesForKeysWithDictionary:dic];
            [weakSelf.albumArray addObject:playList];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayList *playList = [self.allDataArray firstObject];
    if (indexPath.row == 0) {
        DetaileCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detaileCell" forIndexPath:indexPath];
        [cell NightWithType:UIViewColorTypeNormal];
        cell.hostText.text = [playList.host[0] objectForKey:@"name"];
        cell.uploadingText.text = playList.uploadUserName;
        cell.accreditText.text = playList.copyrightLabel;
        cell.statusText.text = [NSString stringWithFormat:@"%@%@",playList.status,playList.updateDay];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) {
        KeywordsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"keyWordCell" forIndexPath:indexPath];
        [cell NightWithType:UIViewColorTypeNormal];
            cell.buttonArray = playList.keyWords.mutableCopy;
        self.heightForCellButton = cell.numberOfButton;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2) {
        IntroductionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"introductionCell" forIndexPath:indexPath];
        [cell NightWithType:UIViewColorTypeNormal];
        cell.introductionText.text = playList.radioDesc;
       self.heightForCellText = [SmallTools textHeightWithText:cell.introductionText.text font:[UIFont systemFontOfSize:13]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 3) {
        AlbumDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"albumCell" forIndexPath:indexPath];
        [cell bindWithArray:self.albumArray];
        [cell NightWithType:UIViewColorTypeNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell NightWithType:UIViewColorTypeNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == 1){
        return self.heightForCellButton * 40;
    }else if (indexPath.row == 2) {
        return self.heightForCellText + 50;
    }else if (indexPath.row == 3) {
        return 190;
    }
    else {
    return 100;
    }
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
