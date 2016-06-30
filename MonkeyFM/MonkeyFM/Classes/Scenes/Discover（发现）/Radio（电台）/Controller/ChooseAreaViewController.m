//
//  ChooseAreaViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ChooseAreaViewController.h"
#import "RadioAreaModel.h"


@interface ChooseAreaViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *chooseTableView;

@property (nonatomic, strong) NSMutableArray *allAreaInfoArray;

@end

@implementation ChooseAreaViewController

static NSString * const identifier_cell = @"identifier_cell";

- (NSMutableArray *)allAreaInfoArray
{
    if (!_allAreaInfoArray) {
        _allAreaInfoArray = [NSMutableArray array];
    }
    return _allAreaInfoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择地区";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    self.navigationItem.rightBarButtonItem = nil;
    [self setTableView];
    [self requestData];
    
}

- (void)setTableView
{
    __weak typeof(self) weakSelf = self;
    self.chooseTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.chooseTableView.delegate = self;
    self.chooseTableView.dataSource = self;
    self.chooseTableView.backgroundColor = [UIColor whiteColor];
    [self.chooseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier_cell];
    [self.view addSubview:self.chooseTableView];
    [self.chooseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
    }];
}

- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:RADIO_AREA_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"result"];
        NSArray *infoArray = [dic objectForKey:@"dataList"];
        for (NSDictionary *dict in infoArray) {
            RadioAreaModel *model = [[RadioAreaModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.allAreaInfoArray addObject:model];
        }
        // 请求完数据，会主线程刷新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadUI];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)reloadUI
{
    [self.chooseTableView reloadData];
}

- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allAreaInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_cell forIndexPath:indexPath];
    RadioAreaModel *model = self.allAreaInfoArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioAreaModel *model = self.allAreaInfoArray[indexPath.row];
    if (self.block) {
        self.block([model.ID integerValue], model.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
