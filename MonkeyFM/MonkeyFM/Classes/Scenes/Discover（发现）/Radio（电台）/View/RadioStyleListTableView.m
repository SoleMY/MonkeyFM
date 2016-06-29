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

@interface RadioStyleListTableView ()<UITableViewDelegate,UITableViewDataSource>



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
        
    }
    return self;
}



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
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)setEmptyURL:(NSString *)emptyURL
{
    if (_emptyURL != emptyURL) {
        _emptyURL = emptyURL;
    }
    [self requestData];
}

- (void)setTableViewHeaderView
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    titleLabel.text = @"北京市";
    [tableHeaderView addSubview:titleLabel];
    UIButton *more = [UIButton buttonWithType:UIButtonTypeSystem];
    more.backgroundColor = [UIColor blackColor];
    [tableHeaderView addSubview:more];
    
    self.tableHeaderView = tableHeaderView;

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
                    [weakSelf setTableViewHeaderView];
                }
                [weakSelf reloadData];
                
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

@end
