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
typedef void(^SubsribeBlock)();
//typedef void(^Sub)(NSIndexPath *);
@interface SubscribeCell : BaseCell

@property (nonatomic, copy)SubBlock block;

@property (nonatomic, copy)SubsribeBlock subsribeblock;

//@property (nonatomic, copy)Sub subBlock;

@property (nonatomic, strong)CollectionView *SubscribeView;

@property (nonatomic, strong)NSMutableArray *collectionArr;

@end
