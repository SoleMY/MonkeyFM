//
//  MainTableView.m
//  MryNewsFrameWork
//
//  Created by mryun11 on 16/6/7.
//  Copyright © 2016年 mryun11. All rights reserved.
//

#import "MryPageTable.h"
#import "NewsCell.h"
#import "PlayListViewController.h"
#import "SingleList.h"
@interface MryPageTable ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *newsAllArray;
@end

@implementation MryPageTable

- (NSMutableArray *)newsAllArray
{
    if (!_newsAllArray) {
        _newsAllArray = [NSMutableArray array];
    }
    return _newsAllArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)setString:(NSString *)string
{
    if (_string != string) {
        
        _string = string;
        
        [self requstTableViewData];
    }
}


- (void)requstTableViewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        NSDictionary *dict = responseObject[@"result"];
        
        NSArray *dataListArray = dict[@"dataList"];
        
        for (NSDictionary *modelDic in dataListArray) {
            NewsAllModel *model = [[NewsAllModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [self.newsAllArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsAllArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
#warning 夜间模式改动
    [cell NightWithType:UIViewColorTypeNormal];
 
    NewsAllModel *model = self.newsAllArray[indexPath.row];

    NSURL *url = [NSURL URLWithString:model.pic];

    [cell.pic sd_setImageWithURL:url];

    cell.descLabel.text = model.desc;
    
    cell.nameLabel.text = model.name;
    
    if ([model.hot floatValue] > 10000) {
       cell.hotLabel.text = [NSString stringWithFormat:@"%.1f万",[model.hot floatValue] / 10000];
    } else {
        cell.hotLabel.text = [NSString stringWithFormat:@"%@", model.hot];
    }
    
    cell.utimeLabel.text = model.utime;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsAllModel *new = self.newsAllArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%ld", new.Id];
//    NSLog(@"++++%ld", new.Id);
    [[SingleList shareSingleList].dict setValue:str forKey:@"ID"];
    self.block();
    
   
//    
}
@end
