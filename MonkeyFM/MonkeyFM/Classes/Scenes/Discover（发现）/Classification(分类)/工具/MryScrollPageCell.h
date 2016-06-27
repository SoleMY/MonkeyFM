//
//  VCTableViewCell.h
//  MryNewsFrameWork
//
//  Created by mryun11 on 16/6/6.
//  Copyright © 2016年 mryun11. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MryScrollPageCell : UITableViewCell

@property (nonatomic,weak) UITableView *tableView;

#pragma mark change
/// 头像
@property (nonatomic, strong) UIImageView *pic;

/// 标题
@property (nonatomic, strong) UILabel *nameLabel;

/// 内容
@property (nonatomic, strong) UILabel *descLabel;

/// 评论数
@property (nonatomic, strong) UILabel *hotLabel;

/// 评论数图图片
@property (nonatomic, strong) UIImageView *hotImageView;

/// 时间
@property (nonatomic, strong) UILabel *utimeLabel;

/// 时间图片
@property (nonatomic, strong) UIImageView *utimeImageView;

/// 图片上的button
@property (nonatomic, strong) UIImageView *button;
@end
