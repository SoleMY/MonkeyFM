//
//  RadioStyleCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"
@class RadioStyleModel;

@interface RadioStyleCell : BaseCell

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *desLabel;
@property (strong, nonatomic) UIImageView *heardImageView;
@property (strong, nonatomic) UILabel *listenPeopleNum;
@property (strong, nonatomic) UIImageView *attentionImageView;
@property (strong, nonatomic) UILabel *attentionLabel;

@property (nonatomic, strong) UIImageView *playImageView;

- (void)bindModel:(RadioStyleModel *)model;

@end
