//
//  RadioStyleListTableView.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioStyleListTableView.h"
#import "RadioStyleCell.h"
#import "RadioStyleModel.h"
#import "ChooseAreaViewController.h"
#import "RadioDisPlayDetailViewController.h"
#import "MJRefresh.h"

#define kButtonSize CGSizeMake(30, 20)

#define kHeaderWidth [UIScreen mainScreen].bounds.size.width

#define kHeaderHeight 30

@interface RadioStyleListTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger length;

@end



@implementation RadioStyleListTableView

static NSString * const identifier_styleCell = @"identifier_styleCell";

- (NSMutableArray *)allTableViewInfoArray
{
    if (!_allTableViewInfoArray) {
        _allTableViewInfoArray = [NSMutableArray array];
    }
    return _allTableViewInfoArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[RadioStyleCell class] forCellReuseIdentifier:identifier_styleCell];
        self.count = 0;
        self.length = 0;
        __weak typeof(self) weakSelf = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf reloadData];
            [weakSelf.mj_header endRefreshing];
            
        }];
        [self NightWithType:UIViewColorTypeNormal];

    }
    return self;
}

#pragma mark - UITableViewDataSourceMethod ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTableViewInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RadioStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_styleCell];
    if (self.allTableViewInfoArray.count > 0) {
        
        RadioStyleModel *model = self.allTableViewInfoArray[indexPath.row];
        [cell bindModel:model];
        [cell NightWithType:UIViewColorTypeNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioStyleModel *model = self.allTableViewInfoArray[indexPath.row];
    
    if (self.displayBlock) {
        if (!_area) {
            _area = 1;
        }
        self.displayBlock([model.ID integerValue], [model.classifyid integerValue], _area, indexPath);
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)setEmptyURL:(NSString *)emptyURL
{
    if (_emptyURL != emptyURL) {
        _emptyURL = emptyURL;
    }
    if (self.count == 0) {
        [self requestData];
    }
    
}

- (void)setAreaName:(NSString *)areaName
{
    if (_areaName != areaName) {
        _areaName = areaName;
    }
    [self setTableViewHeaderView:_areaName];
}

- (void)setTableViewHeaderView:(NSString *)name
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
//    tableHeaderView.backgroundColor = [UIColor whiteColor];
    [tableHeaderView NightWithType:UIViewColorTypeNormal];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = name;
    titleLabel.textColor = kNavigationBarTintColor;
    titleLabel.font = [UIFont systemFontOfSize:13];
    
    [tableHeaderView addSubview:titleLabel];
        UIButton *more = [UIButton buttonWithType:UIButtonTypeSystem];
    [more setImage:[[UIImage imageNamed:@"btn_anchor_more@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(chooseArea:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableHeaderView).offset(5);
        make.right.equalTo(tableHeaderView).offset(-5);
        make.size.mas_equalTo(kButtonSize);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(more.mas_centerY);
        make.left.equalTo(tableHeaderView).offset(15);
        make.width.mas_equalTo(150);
    }];
    self.tableHeaderView = tableHeaderView;

    [tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kHeaderWidth);
        make.height.mas_equalTo(kHeaderHeight);
        make.left.equalTo(self.tableHeaderView);
    }];
}

- (void)chooseArea:(id)sender
{
    if (self.chooseBlock) {
        self.chooseBlock();
    }
    // 记录点击次数
    self.count++;
    
}

- (void)setArea:(NSInteger)area
{
    if (_area != area) {
        _area = area;
    }
    NSRange range = [self.emptyURL rangeOfString:@"&area="];
    NSString *str = [self.emptyURL substringToIndex:(range.location + range.length)];
    NSInteger index = 1;
    if (self.count > 1) {
        if (self.length > 10) {
            index++;
        }
    }
    NSString *str2 = [self.emptyURL substringFromIndex:(range.location + range.length + index)];
    self.emptyURL = [NSString stringWithFormat:@"%@%ld%@", str, self.area, str2];
    [self.allTableViewInfoArray removeAllObjects];
    [self requestData];
    self.length = _area;
    
}

- (void)requestData
{
    __weak typeof(self) weakSelf = ((RadioStyleListTableView *)self);
    self.allTableViewInfoArray = [NSMutableArray array];
    [[AFHTTPSessionManager manager] GET:self.emptyURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"result"];
        if (dict != nil) {
            
            NSArray *listArray = [dict objectForKey:@"dataList"];
            for (NSDictionary *dic in listArray) {
                
                RadioStyleModel *model = [[RadioStyleModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.allTableViewInfoArray addObject:model];
                
            }
            // 数据解析成功，返回主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([weakSelf.title isEqualToString:@"省市台"]) {
                    if (_areaName.length == 0) {
                        [weakSelf setTableViewHeaderView:@"北京"];
                    } else {
                    [weakSelf setTableViewHeaderView:_areaName];
                    }
                }
                [weakSelf reloadData];
                
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}



@end
