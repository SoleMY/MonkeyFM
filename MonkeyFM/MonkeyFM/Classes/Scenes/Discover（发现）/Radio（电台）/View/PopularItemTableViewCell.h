//
//  PopularItemTableViewCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"
//@class CollectionView;

typedef void(^block)(NSString *);
typedef void(^Block)(NSInteger);
typedef void(^pushNewControllerPopularBlock)(NSString *,NSString *);
@interface PopularItemTableViewCell : BaseCell

//@property (nonatomic, strong) CollectionView *radioTypeView;
// 接收数据
@property (nonatomic, strong) NSMutableArray *allInfoDataArray;

@property (nonatomic, copy) pushNewControllerPopularBlock pushBlock;
@property (nonatomic, copy) block block;
@property (nonatomic, copy) Block radioBlock;


@end
