//
//  PopularItemTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "PopularItemTableViewCell.h"
#import "CollectionView.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "RadioModel.h"
#import "HostTitle.h"
#import "Host.h"
@interface PopularItemTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) CollectionView *radioPopularCollectionView;
@property (nonatomic, strong) NSString *relatedValue;

@end

@implementation PopularItemTableViewCell
// 全局重用标识符
static NSString * const identifier_popularCell = @"identifier_popularCell";


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //初始化按钮集合视图
        [self createRadioHeaderView];
    }
    return self;
}
- (void)createRadioHeaderView
{
    self.radioPopularCollectionView = [[CollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    self.radioPopularCollectionView.collectionView.delegate = self;
    self.radioPopularCollectionView.collectionView.dataSource = self;
    [self.contentView addSubview:self.radioPopularCollectionView];
    self.radioPopularCollectionView.collectionView.scrollEnabled = NO;
    self.radioPopularCollectionView.collectionView.showsVerticalScrollIndicator = NO;
    self.radioPopularCollectionView.collectionView.bounces = NO;
#warning 夜间模式改动
    [self.radioPopularCollectionView NightWithType:UIViewColorTypeNormal];
    //   第一步： 注册collectionViewCell
    [self.radioPopularCollectionView.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_popularCell];
    [self.radioPopularCollectionView.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //    注册头视图
    [self.radioPopularCollectionView.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.radioPopularCollectionView.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];

}
//设置多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//设置每一个分区里有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

//返回每一个item的cell对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    第二步：重用cell
    if (self.allInfoDataArray.count > 0) {
        
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_popularCell forIndexPath:indexPath];
        RadioModel *model = [[RadioModel alloc] init];
        model = self.allInfoDataArray[3];
        self.relatedValue = model.relatedValue;
        [cell bindPopularModel:model indexPath:indexPath];
        cell.headPortrait.layer.cornerRadius = 0;
#warning 夜间模式改动
        [cell NightWithType:UIViewColorTypeNormal];
       
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allInfoDataArray.count > 0) {
        RadioModel *model = self.allInfoDataArray[3];
        NSDictionary *dic = model.dataList[indexPath.row];
        Host *host = [[Host alloc] init];
        [host setValuesForKeysWithDictionary:dic];
        if ([host.rtype integerValue] == 0) {
            if (self.block) {
                self.block(host.rvalue);
            }
        } else {
            if (self.radioBlock) {
                self.radioBlock([host.rvalue integerValue]);
            }
        }
    }
}

//返回头视图和尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.allInfoDataArray.count > 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            HeadCollectionReusableView *otherHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            RadioModel *model = self.allInfoDataArray[3];
            otherHead.titleLabel.text = model.name;
            [otherHead.more setImage:[UIImage imageNamed:@"btn_anchor_more@2x"] forState:UIControlStateNormal];
            [otherHead.more addTarget:self action:@selector(moreActionWithIndexPath:) forControlEvents:UIControlEventTouchUpInside];
            
            return otherHead;
        }else {
            return nil;
        }
    }
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    
    return headView;
    
}

- (void)moreActionWithIndexPath:(NSIndexPath *)indexPath {
    RadioModel *model = self.allInfoDataArray[3];
    self.pushBlock(self.relatedValue, model.name);
}


- (void)setAllInfoDataArray:(NSMutableArray *)allInfoDataArray
{
    if (_allInfoDataArray != allInfoDataArray)
    {
        _allInfoDataArray = allInfoDataArray;
    }
    [self.radioPopularCollectionView.collectionView reloadData];
    
}
@end
