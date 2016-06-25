//
//  RadioContentTableViewCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

typedef void(^pushNewControllerBlock)();
@interface RadioContentTableViewCell : BaseCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) UICollectionView *radioContentView;
// 接收数据
@property (nonatomic, strong) NSMutableArray *allInfoDataArray;

@property (nonatomic, copy) pushNewControllerBlock pushBlock;

@end
