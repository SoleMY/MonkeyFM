//
//  ClassificationView.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ClassificationView.h"

@implementation ClassificationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    // 1.定义collectionView的样式
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置属性
    // 给定item的大小
    self.myFlowLayout.itemSize = CGSizeMake((self.bounds.size.width - 40.1) / 3, (self.bounds.size.width - 40.1) / 3);
    //两个item之间的最小间隙（垂直滚动）
    self.myFlowLayout.minimumInteritemSpacing = 10;
    
    // 设置滚动方向（垂直方向）
    self.myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 设置视图的内边距（逆时针的，上左下右）
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    // 2.布局collectionView
    
    // 创建对象并指定样式
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.myFlowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self addSubview:self.collectionView];
    
}

@end
