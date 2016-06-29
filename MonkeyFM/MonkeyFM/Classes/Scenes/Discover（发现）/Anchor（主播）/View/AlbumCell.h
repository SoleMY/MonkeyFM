//
//  AlbumCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"
#import "CollectionView.h"

typedef void(^BaseBlock)();
@interface AlbumCell : BaseCell

@property (nonatomic, copy)BaseBlock block;
@property (nonatomic, strong)CollectionView *AlbumView;
@property (nonatomic, strong)NSMutableArray *albumArr;

@end
