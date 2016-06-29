//
//  RadioTypeTableViewCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

typedef void(^pushNewControllerBlockType)(NSInteger);

@interface RadioTypeTableViewCell : BaseCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *radioTypeView;
// 接收数据
@property (nonatomic, strong) NSMutableArray *allInfoDataArray;

@property (nonatomic, copy) pushNewControllerBlockType pushBlock;

@end
