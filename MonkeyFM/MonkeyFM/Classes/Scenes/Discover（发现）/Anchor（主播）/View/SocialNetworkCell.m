
//
//  SocialNetworkCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SocialNetworkCell.h"
#import "SocialNetWork.h"
#import "HeadCollectionReusableView.h"
@interface SocialNetworkCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SocialNetworkCell
static NSString * const identifier_SocialNetWork = @"identifier_SocialNetWork";


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.myFlowLayout.itemSize = CGSizeMake(70, 70);
    self.myFlowLayout.minimumInteritemSpacing = 10;
    self.myFlowLayout.minimumLineSpacing = 10;
    self.myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直方向
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:self.myFlowLayout];
    [self.contentView addSubview:self.collectionView];
     [self.collectionView registerClass:[SocialNetWork class] forCellWithReuseIdentifier:identifier_SocialNetWork];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView NightWithType:UIViewColorTypeNormal];
    
    __weak typeof(self)weakSelf = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(0);
        make.left.equalTo(weakSelf).offset(0);
        make.right.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf).offset(0);
    }];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headeView"];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SocialNetWork *socialNetWork = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier_SocialNetWork forIndexPath:indexPath];
    return socialNetWork;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath  {
   
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        HeadCollectionReusableView *headView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headeView" forIndexPath:indexPath];
        headView.titleLabel.text = @"TA的";
        return headView;
        } else { 
            return nil;
        }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
        return CGSizeMake(self.bounds.size.width, 20);
}
@end
