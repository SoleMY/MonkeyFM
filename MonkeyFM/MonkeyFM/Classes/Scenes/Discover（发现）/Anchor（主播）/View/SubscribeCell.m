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
#import "HostTitle.h"
#import "SingleList.h"
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

- (void)setCollectionArr:(NSMutableArray *)collectionArr {
    if (collectionArr != _collectionArr) {
        _collectionArr = collectionArr;
    }
    [self.SubscribeView.collectionView reloadData];
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
    [self.SubscribeView.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.SubscribeView.collectionView dequeueReusableCellWithReuseIdentifier:identifier_SubscribeCell forIndexPath:indexPath];
    HostTitle *hostTitle = self.collectionArr[indexPath.row];
    NSURL *url = [NSURL URLWithString:hostTitle.pic];
    [cell.headPortrait sd_setImageWithURL:url];
    cell.nameLabel.text = hostTitle.name;
    cell.headPortrait.layer.cornerRadius = 0;
    cell.introduction.text = @"";
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeadCollectionReusableView *headView = [self.SubscribeView.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_HeaderCell forIndexPath:indexPath];
        headView.titleLabel.text = @"TA的订阅";
        if (self.collectionArr.count >= 3) {
            [headView.more setImage:[UIImage imageNamed:@"btn_anchor_more@2x"] forState:UIControlStateNormal];
            [headView.more addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        }
        return headView;
    }else {
        return nil;
    }
}

- (void)moreAction{
//    NSLog(@"----");
    self.block();
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HostTitle *model = self.collectionArr[indexPath.row];
//    NSString *str= [NSString stringWithFormat:@"%ld", model.Id];
//    NSLog(@"%@", str);
    [[SingleList shareSingleList].dict setObject:model.Id forKey:@"ID"];
    self.subsribeblock();
//    self.subsribeblock(indexPath);
}

@end
