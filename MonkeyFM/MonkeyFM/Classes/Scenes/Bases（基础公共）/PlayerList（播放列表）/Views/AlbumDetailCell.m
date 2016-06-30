
//
//  AlbumDetailCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AlbumDetailCell.h"

@implementation AlbumDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"相关专辑";
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.titleLabel];
    __weak typeof(self)weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    
    self.firstImageView = [[UIImageView alloc] init];
    self.firstImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.firstImageView];
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(7);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(([UIScreen mainScreen].bounds.size.width - 20) / 3);
        make.height.mas_offset(([UIScreen mainScreen].bounds.size.width - 20) / 3);
    }];
    
    self.secondImageView = [[UIImageView alloc] init];
    self.secondImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.secondImageView];
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstImageView).offset(0);
        make.left.equalTo(weakSelf.firstImageView.mas_right).offset(5);
        make.width.mas_offset(([UIScreen mainScreen].bounds.size.width - 20) / 3);
        make.height.mas_offset(([UIScreen mainScreen].bounds.size.width - 20) / 3);
    }];
    
    self.thiredImageView = [[UIImageView alloc] init];
    self.thiredImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.thiredImageView];
    [self.thiredImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondImageView).offset(0);
        make.left.equalTo(weakSelf.secondImageView.mas_right).offset(5);
        make.width.mas_offset(([UIScreen mainScreen].bounds.size.width - 20) / 3);
        make.height.mas_offset(([UIScreen mainScreen].bounds.size.width - 20) / 3);
    }];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.text = @"第一张";
//    self.firstLabel.numberOfLines = 0;
    self.firstLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstImageView.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.firstImageView).offset(0);
        make.right.equalTo(weakSelf.firstImageView).offset(0);
    }];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.text = @"第二章";
    self.secondLabel.font = [UIFont systemFontOfSize:15];
//    self.secondLabel.numberOfLines = 0;
    [self.contentView addSubview:self.secondLabel];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondImageView.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.secondImageView).offset(0);
        make.right.equalTo(weakSelf.secondImageView).offset(0);
    }];
    
    self.thiredLabel = [[UILabel alloc] init];
    self.thiredLabel.text = @"第三章";
    self.thiredLabel.font = [UIFont systemFontOfSize:15];
//    self.thiredLabel.numberOfLines = 0;
    [self.contentView addSubview:self.thiredLabel];
    [self.thiredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.thiredImageView.mas_bottom).offset(5);
        make.right.equalTo(weakSelf.thiredImageView).offset(0);
        make.left.equalTo(weakSelf.thiredImageView).offset(0);
    }];
}

@end
