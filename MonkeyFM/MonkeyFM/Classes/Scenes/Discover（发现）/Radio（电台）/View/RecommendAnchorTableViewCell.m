//
//  RecommendAnchorTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RecommendAnchorTableViewCell.h"
#import "CollectionView.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "RadioModel.h"
#import "HostTitle.h"
#import "Host.h"

@interface RecommendAnchorTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) CollectionView *radioAnchorCollectionView;
@end

@implementation RecommendAnchorTableViewCell

static NSString * const identifier_anchorCell = @"identifier_anchorCell";

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
    self.radioAnchorCollectionView = [[CollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170)];
    self.radioAnchorCollectionView.collectionView.delegate = self;
    self.radioAnchorCollectionView.collectionView.dataSource = self;
    [self.contentView addSubview:self.radioAnchorCollectionView];
//    self.radioAnchorCollectionView.collectionView.footerReferenceSize = CGSizeMake(0, 10);
    self.radioAnchorCollectionView.collectionView.scrollEnabled = NO;
    self.radioAnchorCollectionView.collectionView.showsVerticalScrollIndicator = NO;
    self.radioAnchorCollectionView.collectionView.bounces = NO;
    
    //   第一步： 注册collectionViewCell
    [self.radioAnchorCollectionView.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_anchorCell];
    [self.radioAnchorCollectionView.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //    注册头视图
    [self.radioAnchorCollectionView.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.radioAnchorCollectionView.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];


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
        
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_anchorCell forIndexPath:indexPath];
        RadioModel *model = [[RadioModel alloc] init];
        model = self.allInfoDataArray[4];
        [cell bindRecommendModel:model indexPath:indexPath];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioModel *model = [[RadioModel alloc] init];
    model = self.allInfoDataArray[4];
    NSDictionary *dic = model.dataList[indexPath.row];
    Host *host = [[Host alloc] init];
    [host setValuesForKeysWithDictionary:dic];
    self.pushBlock(host.uid);
}


//返回头视图和尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.allInfoDataArray.count > 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            HeadCollectionReusableView *otherHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            RadioModel *model = self.allInfoDataArray[4];
//            HostTitle *title = self.titleArray[indexPath.section + 1];
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
    self.pushBlock(nil);
}

- (void)setAllInfoDataArray:(NSMutableArray *)allInfoDataArray
{
    if (_allInfoDataArray != allInfoDataArray)
    {
        _allInfoDataArray = allInfoDataArray;
    }
    [self.radioAnchorCollectionView.collectionView reloadData];
    
}
@end
