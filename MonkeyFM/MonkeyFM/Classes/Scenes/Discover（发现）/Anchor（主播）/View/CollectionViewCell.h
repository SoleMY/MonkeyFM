//
//  CollectionViewCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TheHostShow.h"
@class RadioModel;
@interface CollectionViewCell : UICollectionViewCell

//@property (nonatomic, strong)TheHostShow *HostShow;


///头像
@property (nonatomic, strong)UIImageView *headPortrait;

///姓名
@property (nonatomic, strong)UILabel *nameLabel;

///简介
@property (nonatomic, strong)UILabel *introduction;

@property (nonatomic, strong)UIView *myContentView;

// 电台页面使用，在cell页面设置数据
// 两个页面两种绑定数据的方式
- (void)bindRecommendModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath;

- (void)bindPopularModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath;

@end
