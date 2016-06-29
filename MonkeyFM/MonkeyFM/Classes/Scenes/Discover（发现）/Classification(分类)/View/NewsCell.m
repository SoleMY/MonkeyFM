//
//  NewsCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    self.pic = [[UIImageView alloc] init];
    self.pic.image = [UIImage imageNamed:@"ic_homecountry@3x"];
    [self.contentView addSubview:self.pic];
    __weak typeof(self)mySelf = self;
    [self.pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(10);
        make.left.offset(10);
        make.bottom.equalTo(mySelf.contentView).offset(-10);
        make.width.equalTo(mySelf.pic.mas_height);
    }];
    // 图片上的button
    self.button = [[UIImageView alloc] init];
    self.button.image = [UIImage imageNamed:@"播放button"];
    [self.pic addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(mySelf.pic.mas_bottom).offset(-10);
        make.right.equalTo(mySelf.pic.mas_right).offset(-10);
    }];
    
    // title
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"123456667890-";
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mySelf.pic.mas_top).offset(10);
        make.left.equalTo(mySelf.pic.mas_right).offset(10);
        make.right.equalTo(mySelf.contentView).offset(-10);
    }];
    
    // 内容
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.text = @"1234567890-1234567890-1234567890-1234567890-";
    self.descLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.nameLabel.mas_bottom).offset(20);
        // 左对齐
        make.leading.equalTo(mySelf.nameLabel.mas_leading);
        // 右对齐
        make.width.mas_equalTo(250);
        
    }];
    
    // 评论图片
    self.hotImageView = [[UIImageView alloc] init];
    self.hotImageView.image  = [UIImage imageNamed:@"评论数"];
    [self.contentView addSubview:self.hotImageView];
    [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.descLabel.mas_bottom).offset(20);
        make.leading.equalTo(mySelf.descLabel.mas_leading);
       
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        
    }];
    
    // 评论数
    self.hotLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.hotLabel];
    self.hotLabel.text = @"4.3万";
    self.hotLabel.textColor = [UIColor lightGrayColor];
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.descLabel.mas_bottom).offset(20);
        make.left.equalTo(mySelf.hotImageView.mas_right).offset(10);
        make.width.mas_equalTo(80);
        
    }];
    /////////
    // 时间
    self.utimeLabel = [[UILabel alloc] init];
    self.utimeLabel.text = @"10小时前更新";
    self.utimeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.utimeLabel];
    [self.utimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.hotLabel);
        make.right.equalTo(mySelf.hotLabel.mas_right).offset(180);
        make.width.mas_equalTo(150);
        
    }];
    
    // 时间图片
    self.utimeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.utimeImageView];
    self.utimeImageView.image = [UIImage imageNamed:@"时间"];
    [self.utimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.utimeLabel);
        make.right.equalTo(mySelf.utimeLabel.mas_left).offset(-10);
        make.width.equalTo(mySelf.hotImageView.mas_width);
        make.height.equalTo(mySelf.hotImageView.mas_height);

    }];
    
    
}

@end
