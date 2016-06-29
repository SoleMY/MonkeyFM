//
//  SubscribeCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"
#import "CollectionView.h"

typedef void(^SubBlock)();
@interface SubscribeCell : BaseCell

@property (nonatomic, copy)SubBlock block;

@property (nonatomic, strong)CollectionView *SubscribeView;

@property (nonatomic, strong)NSMutableArray *collectionArr;

@end
