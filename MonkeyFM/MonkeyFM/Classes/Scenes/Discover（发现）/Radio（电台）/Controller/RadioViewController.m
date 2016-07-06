//
//  RadioViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioViewController.h"
#import "Request.h"
#import "RadioModel.h"
#import "RadioContentTableViewCell.h"
#import "RadioTypeTableViewCell.h"
#import "RadioPlayerListViewController.h"
#import "RecommendAnchorTableViewCell.h"
#import "AnchorViewController.h"
#import "DrawerViewController.h"
#import "PopularItemTableViewCell.h"
#import "PopularItemListViewController.h"
#import "BaseNavigationViewController.h"
#import "HostInfoViewController.h"
#import "SelecID.h"

#define kHeaderRect CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)
#define kTypeCellHeight [UIScreen mainScreen].bounds.size.width / 2 + 10
#define kContentCellHeight [UIScreen mainScreen].bounds.size.width / 4
#define kNormalCellHeight 150

@interface RadioViewController ()<UITableViewDelegate, UITableViewDataSource>

// 存放所有Model对象的数组
@property (nonatomic, strong) NSMutableArray *allInfoDataArray;
@property (nonatomic, strong) UITableView *radioTableView;

@end

@implementation RadioViewController
// 定义全局的重用标识符
static NSString * const identifier_cell = @"identifier_cell";
static NSString * const identifier_contentCell = @"identifier_contentCell";
static NSString * const identifier_typeCell = @"identifier_typeCell";
static NSString * const identifier_popularCell = @"identifier_popularCell";
static NSString * const identifier_anchorCell = @"identifier_anchorCell";

- (NSMutableArray *)allInfoDataArray
{
    if (!_allInfoDataArray) {
        _allInfoDataArray = [NSMutableArray array];
    }
    return _allInfoDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#warning 夜间模式改动
//    self.view.backgroundColor = [UIColor whiteColor];
    [self createRadioTableView];
    // 数据请求
    [self requestData];
    ((BaseNavigationViewController *)self.navigationController).customSearchBar.hidden = YES;
    self.title = @"电台";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]};
    
}

- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:shuffing_radio_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"result"];
        NSArray *listArray = [dict objectForKey:@"dataList"];
        for (NSDictionary *dic in listArray) {
            RadioModel *model = [[RadioModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.allInfoDataArray addObject:model];
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
    [self.radioTableView reloadData];
}

- (void)createRadioTableView
{
    self.radioTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    #warning 夜间模式改动
    self.radioTableView.backgroundColor = [UIColor  clearColor];
    [self.view addSubview:self.radioTableView];
    
    self.radioTableView.delegate = self;
    self.radioTableView.dataSource = self;
    self.radioTableView.showsVerticalScrollIndicator = NO;
    self.radioTableView.bounces = YES;
    self.radioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.radioTableView.sectionFooterHeight = 0;
    self.radioTableView.sectionHeaderHeight = 0;
    
    [self.radioTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    // 注册cell
    [self registerClassWithCell];
    // 设置头视图
    [self setTableHeaderView];

}

- (void)registerClassWithCell
{
    // 注册系统cell
    [self.radioTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier_cell];
    [self.radioTableView registerClass:[RadioContentTableViewCell class] forCellReuseIdentifier:identifier_contentCell];
    [self.radioTableView registerClass:[RadioTypeTableViewCell class] forCellReuseIdentifier:identifier_typeCell];
    [self.radioTableView registerClass:[PopularItemTableViewCell class] forCellReuseIdentifier:identifier_popularCell];
    [self.radioTableView registerClass:[RecommendAnchorTableViewCell class] forCellReuseIdentifier:identifier_anchorCell];
}

- (void)setTableHeaderView
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:kHeaderRect];
    [[Request alloc] requestWithURL:shuffing_radio_URL view:tableHeaderView frame:kHeaderRect];
    self.radioTableView.tableHeaderView = tableHeaderView;
}

#pragma mark - UITableViewDataSource Delegate Method-----
// 设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
// 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    switch (indexPath.section) {
        case 0:{
            // 第0个分区 类型电台的 cell
            RadioContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_contentCell];
//            cell.radioContentView.backgroundColor = [UIColor whiteColor];
            cell.allInfoDataArray = self.allInfoDataArray;
            cell.pushBlock = ^(NSInteger selectID) {
                RadioPlayerListViewController *listVC = [[RadioPlayerListViewController alloc] init];
                listVC.selectedSegmentIndex = 0;
                listVC.selectID = selectID;
                [SelecID shareSelecID].selectIndex = selectID;
                ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            };
            #warning 夜间模式改动
            [cell NightWithType:UIViewColorTypeNormal];
//            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
            break;
        case 1:{
            //  第1个分区 内容电台的 cell
            RadioTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_typeCell forIndexPath:indexPath];
//            cell.radioTypeView.backgroundColor = [UIColor whiteColor];
            cell.pushBlock = ^(NSInteger selectID) {
                RadioPlayerListViewController *listVC = [[RadioPlayerListViewController alloc] init];
                listVC.selectedSegmentIndex = 1;
                listVC.selectID = selectID;
                [SelecID shareSelecID].selectIndex = selectID;
                ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            };
#warning 夜间模式改动
            [cell NightWithType:UIViewColorTypeNormal];
            cell.allInfoDataArray = self.allInfoDataArray;
            return cell;
        }
            break;
        case 2:{
            // 第2个分区 热播栏目的 cell
            PopularItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_popularCell forIndexPath:indexPath];
            cell.allInfoDataArray = self.allInfoDataArray;
            cell.pushBlock = ^(NSString *relatedValue, NSString *titleName) {
                PopularItemListViewController *popularListVC = [[PopularItemListViewController alloc] init];
                ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
                popularListVC.relatedValue = relatedValue;
                popularListVC.titleName = titleName;
                [weakSelf.navigationController pushViewController:popularListVC animated:YES];
            };
#warning 夜间模式改动
            [cell NightWithType:UIViewColorTypeNormal];
            return cell;
        }
            break;
        case 3:{
            // 第三个分区 推荐主播的 cell
            RecommendAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_anchorCell forIndexPath:indexPath];
            cell.allInfoDataArray = self.allInfoDataArray;
            cell.pushBlock = ^(NSString *uid) {
                if (uid != nil) {
                    HostInfoViewController *hostVC = [[HostInfoViewController alloc] init];
                    hostVC.uid = uid;
                    [weakSelf.navigationController pushViewController:hostVC animated:YES];
                } else {
                    AnchorViewController *anchorVC = [[AnchorViewController alloc] init];
                    [weakSelf.navigationController pushViewController:anchorVC animated:YES];
                    weakSelf.pushBack();
                }
            };
            return cell;
        }
            break;
            default:
            return nil;
            break;
    }
   
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    footerView.backgroundColor = [UIColor colorWithRed:0.91 green:0.90 blue:0.89 alpha:1.00];
//    return footerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kContentCellHeight;
    } else if (indexPath.section == 1) {
        return kTypeCellHeight;
    } else if (indexPath.section == 2) {
        return kNormalCellHeight;
    } else {
        return kNormalCellHeight+ 10;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
