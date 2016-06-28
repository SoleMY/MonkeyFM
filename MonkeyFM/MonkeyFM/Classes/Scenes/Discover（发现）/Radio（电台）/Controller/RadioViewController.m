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

#define kHeaderRect CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)
#define kTypeCellHeight [UIScreen mainScreen].bounds.size.width / 3

@interface RadioViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) RadioView *radioView;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRadioTableView];
    
//    self.radioView.collectionView.delegate = self;
//    self.radioView.collectionView.dataSource = self;
//    // 注册collection相关cell 头尾视图
//    [self registerClassWithCellAndHeaderFooter];
    
    // 数据请求
    [self requestData];
    
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
    self.radioTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.radioTableView];
    self.radioTableView.delegate = self;
    self.radioTableView.dataSource = self;
    self.radioTableView.showsVerticalScrollIndicator = NO;
    self.radioTableView.bounces = NO;
    self.radioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.radioTableView.sectionFooterHeight = 0;
    self.radioTableView.sectionHeaderHeight = 0;
    
    
    [self.view addSubview:_radioTableView];
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
    // 注册头视图
//    [self.radioView.collectionView registerClass:[RadioHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"firstHeaderView"];
//    [self.radioView.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
//    [self.radioView.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"normalHeaderView"];
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
            RadioContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_contentCell];
            cell.radioContentView.backgroundColor = [UIColor whiteColor];
            cell.allInfoDataArray = self.allInfoDataArray;
            cell.pushBlock = ^() {
                RadioPlayerListViewController *listVC = [[RadioPlayerListViewController alloc] init];
                listVC.selectedSegmentIndex = 0;
                ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            };
            return cell;
        }
            break;
        case 1:{
            RadioTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_typeCell forIndexPath:indexPath];
            cell.radioTypeView.backgroundColor = [UIColor whiteColor];
            cell.pushBlock = ^() {
                RadioPlayerListViewController *listVC = [[RadioPlayerListViewController alloc] init];
                listVC.selectedSegmentIndex = 1;
                ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            };
            cell.allInfoDataArray = self.allInfoDataArray;
            return cell;
        }
            break;
        case 2:{
            PopularItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_popularCell forIndexPath:indexPath];
            cell.allInfoDataArray = self.allInfoDataArray;
            cell.pushBlock = ^(NSString *relatedValue, NSString *titleName) {
                PopularItemListViewController *popularListVC = [[PopularItemListViewController alloc] init];
                ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
                popularListVC.relatedValue = relatedValue;
                popularListVC.titleName = titleName;
                [weakSelf.navigationController pushViewController:popularListVC animated:YES];
            };
            return cell;
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_cell forIndexPath:indexPath];
//            cell.backgroundColor = [UIColor redColor];
//            return cell;
        }
            break;
        case 3:{
            RecommendAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_anchorCell forIndexPath:indexPath];
            cell.allInfoDataArray = self.allInfoDataArray;
            cell.pushBlock = ^(NSString *uid) {
                if (uid != nil) {
                    
                }
                AnchorViewController *anchorVC = [[AnchorViewController alloc] init];
                [weakSelf.navigationController pushViewController:anchorVC animated:YES];
                weakSelf.pushBack();
            };
            return cell;
        }
            break;
            default:
        {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_cell forIndexPath:indexPath];
//            cell.backgroundColor = [UIColor redColor];
            return nil;
        }
            break;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    } else if (indexPath.section == 1) {
        return kTypeCellHeight + 20;
    } else if (indexPath.section == 2) {
        return 170;
    } else {
        return 170;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
// 每行的头视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}

/*
#pragma mark UICollectionViewDataSource Method------
// 设置多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

// 设置每个分区里 有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 15;
    } else {
        return 3;
    }
    
}

// 返回每一个item的cell对象那个
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allInfoDataArray.count > 0) {
        if (indexPath.section == 0) {
            return nil;
        } else if (indexPath.section == 1) {
            
                RadioContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_contentCell forIndexPath:indexPath];
    //            cell.topImageView.backgroundColor = [UIColor cyanColor];
                RadioModel *model = [[RadioModel alloc] init];
                model = self.allInfoDataArray[indexPath.section];
                NSDictionary *dic = [model.dataList firstObject];
                NSArray *nameArray = [dic objectForKey:@"dataList"];
                cell.bottomLabel.text = [nameArray[indexPath.row] objectForKey:@"name"];
                cell.topImageView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", cell.bottomLabel.text]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                return cell;
            
        } else if (indexPath.section == 2) {
            RadioTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_typeCell forIndexPath:indexPath];
            RadioModel *model = self.allInfoDataArray[1];
            NSDictionary *dic = [model.dataList lastObject];
            NSArray *nameArray = [dic objectForKey:@"dataList"];
            cell.radioTypeLabel.text = [nameArray[indexPath.row] objectForKey:@"name"];
            return cell;
        }
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 判断头视图还是尾视图
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            RadioHeadReusableView *firstHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"firstHeaderView" forIndexPath:indexPath];
            [[Request alloc] requestWithURL:shuffing_radio_URL view:firstHeaderView frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
//        firstHeaderView.backgroundColor = [UIColor redColor];

            return firstHeaderView;
        } else {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor greenColor];
            return footerView;
        }
    }else {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"normalHeaderView" forIndexPath:indexPath];
            headView.backgroundColor = [UIColor redColor];
            return headView;
        } else {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor greenColor];
            return footerView;
        }
    }
}

#pragma mark 设置header和footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.bounds.size.width, 200);
    } else {
        return CGSizeMake(self.view.bounds.size.width, 70);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 20);
}
*/
@end
