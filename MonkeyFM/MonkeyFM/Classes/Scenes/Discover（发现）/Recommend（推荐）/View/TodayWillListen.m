//
//  TodayWillListen.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "TodayWillListen.h"
#import "CollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "TodayModel.h"
#import "PlayListViewController.h"
#import "SingleList.h"
#import "NetWorking.h"
#import "PlayList.h"
#import "ClassificationController.h"
@interface TodayWillListen ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *allDataArray;

@end
@implementation TodayWillListen

- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

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
    if (_albumArr != albumArr) {
        _albumArr = albumArr;
    }
    [self.AlbumView.collectionView reloadData];
}

- (void)initLayout {
    self.AlbumView = [[CollectionView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    [self.AlbumView NightWithType:UIViewColorTypeNormal];
    self.AlbumView.collectionView.delegate = self;
    self.AlbumView.collectionView.dataSource = self;
    [self.contentView addSubview:self.AlbumView];
    self.AlbumView.collectionView.scrollEnabled = NO;
    self.AlbumView.collectionView.showsVerticalScrollIndicator = NO;
    self.AlbumView.collectionView.bounces = NO;
    [self.AlbumView.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_AlbumCell];
    [self.AlbumView.collectionView NightWithType:UIViewColorTypeNormal];
    [self.AlbumView.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.AlbumView.collectionView dequeueReusableCellWithReuseIdentifier:identifier_AlbumCell forIndexPath:indexPath];
    cell.headPortrait.layer.cornerRadius = 0;
    if (self.albumArr) {
        TodayModel *more = self.albumArr[indexPath.row];
    NSString *URLStr = [NSString stringWithFormat:@"%@", more.pic];
    NSURL *url = [NSURL URLWithString:URLStr];
    [cell.headPortrait sd_setImageWithURL:url];
     cell.nameLabel.numberOfLines = 0;
     cell.nameLabel.text = more.rname;
     cell.headPortrait.frame = CGRectMake(10, -10, 80, 80);
     cell.nameLabel.frame = CGRectMake(0, 70, 100, 50);
    [cell.introduction removeFromSuperview];
    [cell NightWithType:UIViewColorTypeNormal];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        {case 0:
            self.albumBlock();
            break;
        }
        {case 1:
            self.albumBlock();
            break;
        }
        {case 2:
            self.albumBlock();
            break;
        }
        {case 3:
            self.albumBlock();
            break;
        }
        {case 4:
            self.albumBlock();
            break;
        }
        {case 5:
            self.albumBlock();
            break;
        }
        {case 6:
            self.albumBlock();
            break;
        }
        {case 7:
            self.albumBlock();
            break;
        }
        default:
            break;
    }
}

@end
