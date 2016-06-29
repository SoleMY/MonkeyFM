//
//  collectCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

typedef void(^CollectBlock)();
@interface collectCell : BaseCell

@property (nonatomic, copy)CollectBlock block;

@property (nonatomic, strong)UICollectionView *collectView;

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

@property (nonatomic, strong)NSMutableArray *collectArr;

@end
