//
//  AnchorViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AnchorViewController.h"
//#import "TheHostShow.h"
#import "Request.h"
#import "CollectionView.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "FirstCollectionReusableView.h"
#import "NetWorking.h"
#import "HostTitle.h"
#import "Host.h"
#import "HostViewController.h"
#import "HostInfoViewController.h"
#import "BaseNavigationViewController.h"

#define kHeadViewHeight 200
#define kHeadViewY 40
@interface AnchorViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)NSMutableArray *hostArray;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong)CollectionView *collection;
@property (nonatomic, strong)NSString *appendString;

@end

@implementation AnchorViewController

- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)hostArray {
    if (_hostArray == nil) {
        _hostArray = [NSMutableArray array];
    }
    return _hostArray;
}

- (void)loadView {
    self.collection = [[CollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.collection;
}

//定义全局的重用标识符
static NSString *const identifier_cell = @"identifier_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //    设置代理
    self.collection.collectionView.dataSource = self;
    self.collection.collectionView.delegate = self;
#warning 夜间模式改动
    [self.collection.collectionView NightWithType:UIViewColorTypeNormal];
    //   第一步： 注册collectionViewCell
    [self.collection.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_cell];
    //    注册头视图
    [self.collection.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collection.collectionView registerClass:[FirstCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"firstHeaderView"];
    [self request];
    __weak typeof(self)weakSelf = self;
    self.title = @"主播";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]};
}
- (void)request {
    NetWorking *networking = [[NetWorking alloc] init];
    __weak typeof(self)weakSelf = self;
    [networking requestWithURL:shuffing_host_URL Bolck:^(id array) {
        NSDictionary *resultDic = array[@"result"];
                NSArray *dataListArray = [resultDic objectForKey:@"dataList"];
                for (NSDictionary *dict in dataListArray) {
                    HostTitle *title = [[HostTitle alloc] init];
                    [title setValuesForKeysWithDictionary:dict];
                    [self.titleArray addObject:title];
                    if (title.contentType == 4) {
                        for (NSDictionary *dic in title.dataList) {
                            Host *host = [[Host alloc] init];
                            [host setValuesForKeysWithDictionary:dic];
                            [weakSelf.hostArray addObject:host];
                        }
                    }
                }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collection.collectionView reloadData];
        });
    }];

}

#pragma mark UICollectionViewDataSource Method----

//设置多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titleArray.count - 1;
}

//设置每一个分区里有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else if (section ==1){
    return 6;
    } else {
        return 3;
    }
}

//返回每一个item的cell对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }else {
    //    第二步：重用cell
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
#warning 夜间模式改动
        [cell NightWithType:UIViewColorTypeNormal];
        if (indexPath.section == 1) {
            Host *host = self.hostArray[indexPath.row];
            cell.nameLabel.text = host.nickName;
            cell.introduction.text = host.recommendReson;
            [cell.headPortrait sd_setImageWithURL:[NSURL URLWithString:host.avatar]];
            
        }else {
            Host *host = self.hostArray[6 + (indexPath.section - 2) * 3 + indexPath.row ];
            cell.nameLabel.text = host.nickName;
            cell.introduction.text = host.recommendReson;
             [cell.headPortrait sd_setImageWithURL:[NSURL URLWithString:host.avatar]];
        }
        
        HostTitle *hostTitle = self.titleArray[indexPath.section];
        self.appendString = hostTitle.relatedValue;
        
     return cell;
    }
}

//返回头视图和尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
            FirstCollectionReusableView *firstHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"firstHeaderView" forIndexPath:indexPath];
#warning 夜间模式改动
            [firstHeaderView NightWithType:UIViewColorTypeNormal];
            [[Request alloc] requestWithURL:shuffing_host_URL view:firstHeaderView frame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
               return firstHeaderView;
        } else {
            return nil;
    }
    } else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            HeadCollectionReusableView *otherHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            self.compent = indexPath.section;
#warning 夜间模式改动
            [otherHead NightWithType:UIViewColorTypeNormal];
            HostTitle *title = self.titleArray[indexPath.section + 1];
            otherHead.titleLabel.text = title.name;
            [otherHead.more setImage:[UIImage imageNamed:@"btn_anchor_more@2x"] forState:UIControlStateNormal];
            otherHead.more.tag = indexPath.section + 1;
            [otherHead.more addTarget:self action:@selector(moreActionWithIndexPath:) forControlEvents:UIControlEventTouchUpInside];
            return otherHead;
        }else {
            return nil;
        }
    }
}

#pragma mark 设置header和footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.bounds.size.width, 150);
    } else {
        return CGSizeMake(self.view.bounds.size.width, 30);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 0);
}

//点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HostInfoViewController *hostInfoVC = [[HostInfoViewController alloc] init];
    if (indexPath.section == 1) {
        Host *host = self.hostArray[indexPath.row];
        hostInfoVC.uid = host.uid;
    } else {
        Host *host = self.hostArray[6 + (indexPath.section - 2) * 3 + indexPath.row];
        hostInfoVC.uid = host.uid;

    }
    [self.navigationController pushViewController:hostInfoVC animated:YES];
}

- (void)moreActionWithIndexPath:(UIButton *)sender {
    HostTitle *title = self.titleArray[sender.tag];
    self.appendString = title.relatedValue;
    HostViewController *hostVC = [[HostViewController alloc] init];
    hostVC.appendString = self.appendString;
    [self.navigationController pushViewController:hostVC animated:YES];
}


@end
