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
#import "MFM_URL.h"
#import "CollectionView.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "FirstCollectionReusableView.h"
#import "NetWorking.h"
#import "HostTitle.h"
#import "Host.h"
#import <UIImageView+WebCache.h>
#import "HostViewController.h"


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
//    self.collection.collectionView.backgroundColor = [UIColor lightGrayColor];
//   NetWorking *netWorking = [[NetWorking alloc] init];
//    [netWorking request];
    //    设置代理
    self.collection.collectionView.dataSource = self;
    self.collection.collectionView.delegate = self;
    //   第一步： 注册collectionViewCell
    [self.collection.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_cell];
    //    注册头视图
    [self.collection.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collection.collectionView registerClass:[FirstCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"firstHeaderView"];
    //    注册尾视图
    [self.collection.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [self request];
}
- (void)request {
    NetWorking *networking = [[NetWorking alloc] init];
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
                            [self.hostArray addObject:host];
                        }
                    }
                }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collection.collectionView reloadData];
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
        
     return cell;
    }
}

//返回头视图和尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
            FirstCollectionReusableView *firstHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"firstHeaderView" forIndexPath:indexPath];
            [[Request alloc] requestWithURL:shuffing_host_URL view:firstHeaderView frame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
               return firstHeaderView;
        } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor greenColor];
    return footerView;
    }
    } else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            HeadCollectionReusableView *otherHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            HostTitle *title = self.titleArray[indexPath.section + 1];
            otherHead.titleLabel.text = title.name;
            [otherHead.more setImage:[UIImage imageNamed:@"btn_anchor_more@2x"] forState:UIControlStateNormal];
            self.compent = indexPath.section;
            self.appendString = title.relatedValue;
            [otherHead.more addTarget:self action:@selector(moreActionWithIndexPath:) forControlEvents:UIControlEventTouchUpInside];
            
            return otherHead;
        }else {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
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
        return CGSizeMake(self.view.bounds.size.width, 30);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 0);
}

////点击item
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:secondVC animated:YES];
//}

- (void)moreActionWithIndexPath:(NSIndexPath *)indexPath {
    HostViewController *hostVC = [[HostViewController alloc] init];
//    hostVC.appendString = self.compent;
    hostVC.appendString = self.appendString;
    [self.navigationController pushViewController:hostVC animated:YES];
}


@end
