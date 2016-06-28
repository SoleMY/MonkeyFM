//
//  PopularItemListViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "PopularItemListViewController.h"
#import "PopularItemListCell.h"
#import "RadioPopularItemModel.h"
@interface PopularItemListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *popularTableView;
// 存放所有数据的大数组
@property (nonatomic, strong) NSMutableArray *allListInfoArray;

@end

@implementation PopularItemListViewController

static NSString * const identifier_popularListCell = @"identifier_popularListCell";

- (NSMutableArray *)allListInfoArray
{
    if (!_allListInfoArray) {
        _allListInfoArray = [NSMutableArray array];
    }
    return _allListInfoArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UITableView *popularTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    popularTableView.delegate = self;
    popularTableView.dataSource = self;
    [popularTableView registerClass:[PopularItemListCell class] forCellReuseIdentifier:identifier_popularListCell];
    [self.view addSubview:popularTableView];
    self.popularTableView = popularTableView;
    __weak typeof(self)weakSelf = self;
    [self.popularTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(64);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    // 请求数据
    [self requestData];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestData
{
    
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:RADIO_POPULARITEM_LIST_URL(RADIO_POPULARITEM_BASE_URL, self.relatedValue, RADIO_POPULARITEM_TAIL_URL) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"result"];
        NSArray *listArray = [dict objectForKey:@"dataList"];
        for (NSDictionary *dic in listArray) {
            RadioPopularItemModel *model = [[RadioPopularItemModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.allListInfoArray addObject:model];
        }
        // 数据解析成功，返回主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadDataAndShowUI];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)reloadDataAndShowUI
{
    [self.popularTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allListInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PopularItemListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_popularListCell forIndexPath:indexPath];
    RadioPopularItemModel *model = self.allListInfoArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
