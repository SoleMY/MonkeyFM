//
//  CollectionView.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        初始化布局
        [self initLayout];
    }
    return self;
}

//初始化布局
- (void)initLayout {
    
    //    1.定义collectionView的样式
    
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    设置属性
    //    给定item的大小
    self.myFlowLayout.itemSize = CGSizeMake((self.bounds.size.width - 40.01) / 3, 80);
    //    每两个item的最小间隙（垂直滚动）
    self.myFlowLayout.minimumInteritemSpacing = 10;
    //    每两个item的最小间隙（水平滚动）
    self.myFlowLayout.minimumLineSpacing = 10;
    //    设置滚动方向
    self.myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直方向
    //    设置视图的内边距（上左下右）
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //    布局头视图尺寸
    self.myFlowLayout.headerReferenceSize = CGSizeMake(30, 80);
    
    //    布局尾视图的尺寸
    self.myFlowLayout.footerReferenceSize = CGSizeMake(30, 40);
    
    //    2.布局collectionView
    
    //    创建对象并指定样式
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.myFlowLayout];
    self.collectionView.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.collectionView];
    
    
}@end
