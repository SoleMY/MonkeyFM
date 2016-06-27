//
//  AlbumCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"
#import "CollectionView.h"
@interface AlbumCell : BaseCell

@property (nonatomic, strong)CollectionView *AlbumView;
@property (nonatomic, strong)NSMutableArray *albumArr;
@property (nonatomic, strong)NSMutableArray *array;

@end
