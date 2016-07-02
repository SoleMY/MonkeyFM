//
//  MineTableViewCell.h
//  Mine
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 孟令旭. All rights reserved.
//


#import "BaseCell.h"

@interface MineTableViewCell : BaseCell

/// 头像
@property (nonatomic, strong) UIImageView *pic;

/// 标题
@property (nonatomic, strong) UILabel *nameLabel;

/// 内容
@property (nonatomic, strong) UILabel *descLabel;

/// 时间
@property (nonatomic, strong) UILabel *utimeLabel;

/// 图片上的button
@property (nonatomic, strong) UIImageView *button;

@end
