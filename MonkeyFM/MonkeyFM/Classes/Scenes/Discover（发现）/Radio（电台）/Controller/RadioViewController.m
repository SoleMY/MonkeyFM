//
//  RadioViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioView.h"
#import "RadioHeadReusableView.h"
#import "Request.h"
#import "MFM_URL.h"

@interface RadioViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) RadioView *radioView;

@end

@implementation RadioViewController
// 定义全局的重用标识符
static NSString * const identifier_cell = @"identifier_cell";

- (void)loadView
{
    self.radioView = [[RadioView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.radioView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    self.radioView.collectionView.delegate = self;
    self.radioView.collectionView.dataSource = self;
    // 注册Cell
    [self.radioView.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier_cell];
    // 注册头视图
    [self.radioView.collectionView registerClass:[RadioHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"firstHeaderView"];
    [self.radioView.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
     [self.radioView.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"normalHeaderView"];
    
}

#pragma mark UICollectionViewDataSource Method------

// 设置多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

// 设置每个分区里 有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 19;
    }
    return 10;
}

// 返回每一个item的cell对象那个
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    RootCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor lightGrayColor];
    //    if (indexPath.section == 0) {
    //        cell.photoImageView.image = [UIImage imageNamed:@"1.jpg"];
    //    }else if (indexPath.section == 1) {
    //        cell.photoImageView.image = [UIImage imageNamed:@"2.jpg"];
    //    }else if (indexPath.section == 2) {
    //        cell.photoImageView.image = [UIImage imageNamed:@"111"];
    //    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 判断头视图还是尾视图
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            RadioHeadReusableView *firstHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"firstHeaderView" forIndexPath:indexPath];
            [[Request alloc] requestWithURL:shuffing_radio_URL view:firstHeaderView frame:CGRectMake(0, 0, 375, 200)];
//        firstHeaderView.backgroundColor = [UIColor redColor];
            return firstHeaderView;
        } else {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor greenColor];
            return footerView;
        }
    }else {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"normalHeaderView" forIndexPath:indexPath];
            headView.backgroundColor = [UIColor redColor];
            return headView;
        } else {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
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
        return CGSizeMake(self.view.bounds.size.width, 70);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 20);
}

@end
