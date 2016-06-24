//
//  ClassificationView.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseView.h"

@interface ClassificationView : BaseView
// 声明集合视图属性

@property (nonatomic, strong)UICollectionView *collectionView;

//UICollectionViewFlowLayout用来给UICollectionView布局的

@property (nonatomic, strong)UICollectionViewFlowLayout *myFlowLayout;
@end
