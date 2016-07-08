//
//  MoreCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "MoreCell.h"

@implementation MoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
        }
    return self;
}

- (void)initLayout {
    self.picture = [[UIImageView alloc] init];
    self.picture.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.picture];
    __weak typeof(self)weakSelf = self;
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.height.mas_offset(50);
        make.width.mas_offset(50);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = @"空空谈股市";
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.picture.mas_right).offset(5);
        make.height.mas_offset(25);
        make.width.mas_offset(200);
    }];
    [self.titleLabel NightWithType:UIViewColorTypeNormal];
    [self.titleLabel NightTextType:LabelColorBlack];
    
    self.subLabel = [[UILabel alloc] init];
    self.subLabel.text = @"空空谈股市";
//    self.subLabel.textColor = [UIColor grayColor];
    self.subLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.picture.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(300);
    }];
    [self.subLabel NightWithType:UIViewColorTypeNormal];
    [self.subLabel NightTextType:LabelColorGray];
    
}

@end
