//
//  collectCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "collectCell.h"
#import "Collect.h"
#import "HeadCollectionReusableView.h"
#import "Collection.h"
@interface collectCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation collectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

//- (NSMutableArray *)collectArr {
//    if (!_collectArr) {
//        _collectArr = [NSMutableArray array];
//    }
//    return _collectArr;
//}

- (void)setCollectArr:(NSMutableArray *)collectArr {
    if (collectArr != _collectArr) {
        _collectArr = collectArr;
    }
    [self.collectView reloadData];
}


- (void)initLayout  {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(self.frame.size.width, 60);
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直方向
    self.layout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
    
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:self.layout];
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectView];
    
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.scrollEnabled = NO;
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.bounces = NO;
    [self.collectView registerClass:[Collect class] forCellWithReuseIdentifier:@"collectCell"];
    [self.collectView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headeView"];
    
    [self.collectView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Collect *cell = [self.collectView dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    Collection *collection = self.collectArr[indexPath.row];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:collection.audioPic]];
    cell.titleLabel.text = collection.audioName;
    cell.decLabel.text = collection.albumName;
    cell.dateLabel.text = collection.updateTime;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath  {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        HeadCollectionReusableView *headView = [self.collectView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headeView" forIndexPath:indexPath];
        headView.titleLabel.text = @"TA的收藏";
        if (self.collectArr.count >= 3) {
            [headView.more setImage:[UIImage imageNamed:@"btn_anchor_more@2x"] forState:UIControlStateNormal];
            [headView.more addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        }
        return headView;
    } else {
        return nil;
    }
}

- (void)moreAction {
    self.block();
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.collectBlock();
}


@end
