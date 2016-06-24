//
//  RadioView.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioView.h"

@implementation RadioView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 布局视图
        [self initLayout];
    }
    return self;
}

// 布局视图
- (void)initLayout
{
    // 1.定义collectionView的样式
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置属性
    // 给定Item的大小（单元格）
    self.myFlowLayout.itemSize = CGSizeMake((self.bounds.size.width - 50) / 4, (self.bounds.size.width - 50) / 4);
    // 每两个Item的最小间隙（垂直滚动）
    self.myFlowLayout.minimumInteritemSpacing = 10;
    // 每两个Item的最小间隙（水平滚动方向）
    self.myFlowLayout.minimumLineSpacing = 10;
    
    // 设置滚动方向(Vertical垂直方向，horizontal水平方向)
    self.myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置视图的内边距（逆时针顺序）
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 设置头视图，尾视图的大小(宽度不起作用，默认视图宽)
    self.myFlowLayout.headerReferenceSize = CGSizeMake(0, 50);
    self.myFlowLayout.footerReferenceSize = CGSizeMake(0, 50);
    
    // 2.布局collectionView
    // 创建对象，并指定样式
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.myFlowLayout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.collectionView];
}


@end
