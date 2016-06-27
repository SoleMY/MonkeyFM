//
//  SubscribeCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SubscribeCell.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"

@interface SubscribeCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end


@implementation SubscribeCell
static NSString *const identifier_SubscribeCell = @"identifier_Subscribe";
static NSString *const identifier_HeaderCell = @"identifier_HeaderCell";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.SubscribeView = [[CollectionView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    self.SubscribeView.backgroundColor = [UIColor redColor];
    self.SubscribeView.collectionView.delegate = self;
    self.SubscribeView.collectionView.dataSource = self;
    [self.contentView addSubview:self.SubscribeView];
    self.SubscribeView.collectionView.scrollEnabled = NO;
    self.SubscribeView.collectionView.showsVerticalScrollIndicator = NO;
    self.SubscribeView.collectionView.bounces = NO;
    [self.SubscribeView.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_SubscribeCell];
    [self.SubscribeView.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_HeaderCell];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.SubscribeView.collectionView dequeueReusableCellWithReuseIdentifier:identifier_SubscribeCell forIndexPath:indexPath];
    cell.headPortrait.backgroundColor = [UIColor blueColor];
    cell.headPortrait.layer.cornerRadius = 0;
    cell.nameLabel.text = @"空空";
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeadCollectionReusableView *headView = [self.SubscribeView.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_HeaderCell forIndexPath:indexPath];
        headView.titleLabel.text = @"TA的订阅";
        return headView;
    }else {
        return nil;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 20);
}


@end
