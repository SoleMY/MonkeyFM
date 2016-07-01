//
//  AlbumCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AlbumCell.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "More.h"
#import "PlayListViewController.h"
#import "SingleList.h"
@interface AlbumCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation AlbumCell
//@synthesize albumArr = _albumArr;
static NSString * const identifier_AlbumCell = @"identifier_Album";
static NSString * const identifier_HeaderCell = @"identifier_HeaderCell";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
        }
    return self;
}



- (void)setAlbumArr:(NSMutableArray *)albumArr {
    if (albumArr!=_albumArr) {
        _albumArr = albumArr;
        
    }
    [self.AlbumView.collectionView reloadData];
}

- (void)initLayout {
    self.AlbumView = [[CollectionView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    self.AlbumView.backgroundColor = [UIColor redColor];
    self.AlbumView.collectionView.delegate = self;
    self.AlbumView.collectionView.dataSource = self;
    [self.contentView addSubview:self.AlbumView];
    self.AlbumView.collectionView.scrollEnabled = NO;
    self.AlbumView.collectionView.showsVerticalScrollIndicator = NO;
    self.AlbumView.collectionView.bounces = NO;
    [self.AlbumView.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_AlbumCell];
    [self.AlbumView.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_HeaderCell];
    [self.AlbumView.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.AlbumView.collectionView dequeueReusableCellWithReuseIdentifier:identifier_AlbumCell forIndexPath:indexPath];
    cell.headPortrait.layer.cornerRadius = 0;
    More *more = self.albumArr[indexPath.row];
    NSString *URLStr = [NSString stringWithFormat:@"%@", more.pic];
    NSURL *url = [NSURL URLWithString:URLStr];
    [cell.headPortrait sd_setImageWithURL:url];
    cell.nameLabel.text = more.name;
    cell.introduction.text = @"";
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeadCollectionReusableView *headView = [self.AlbumView.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_HeaderCell forIndexPath:indexPath];
        headView.titleLabel.text = @"TA发布的专辑";
        if (self.albumArr.count >= 3) {
            [headView.more setImage:[UIImage imageNamed:@"btn_anchor_more@2x"] forState:UIControlStateNormal];
            [headView.more addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return headView;
    }else {
        return nil;
    }
}

- (void)moreAction{
    self.block();
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    More *model = self.albumArr[indexPath.row];
    NSString *str= [NSString stringWithFormat:@"%ld", model.Id];
    [[SingleList shareSingleList].dict setObject:str forKey:@"ID"];

    self.albumBlock();
}

@end
