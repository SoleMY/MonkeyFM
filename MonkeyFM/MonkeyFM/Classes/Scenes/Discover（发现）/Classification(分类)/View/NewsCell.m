//
//  NewsCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "NewsCell.h"

#define kSpace 10
#define imageWidth 30
#define cellHeightAndSpace [UIScreen mainScreen].bounds.size.width - 130
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
        make.top.equalTo(mySelf.contentView).offset(kSpace);
        make.left.offset(kSpace);
        make.bottom.equalTo(mySelf.contentView).offset(-kSpace);
        make.width.equalTo(mySelf.pic.mas_height);
    }];
    // 图片上的button
    self.button = [[UIImageView alloc] init];
    self.button.image = [UIImage imageNamed:@"播放button"];
    [self.pic addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageWidth);
        make.bottom.equalTo(mySelf.pic.mas_bottom).offset(-kSpace);
        make.right.equalTo(mySelf.pic.mas_right).offset(-kSpace);
    }];
    
    // title
    self.nameLabel = [[UILabel alloc] init];
<<<<<<< HEAD
    self.nameLabel.font = [UIFont systemFontOfSize:16];
#warning 夜间模式改动
=======
>>>>>>> 3fad5033ffa37dc8184f694c766549717fe6dd3b
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mySelf.pic.mas_top).offset(kSpace);
        make.left.equalTo(mySelf.pic.mas_right).offset(kSpace);
         make.width.mas_equalTo(cellHeightAndSpace);
    }];
    
    // 内容
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = [UIFont systemFontOfSize:14];
    [self.descLabel NightWithType:UIViewColorTypeNormal];
    [self.descLabel NightTextType:LabelColorBlack];
    self.descLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.nameLabel.mas_bottom).offset(10);
        // 左对齐
        make.leading.equalTo(mySelf.nameLabel.mas_leading);
        // 右对齐
        make.width.mas_equalTo(cellHeightAndSpace);
        
    }];
    
    // 评论图片
    self.hotImageView = [[UIImageView alloc] init];
    self.hotImageView.image  = [UIImage imageNamed:@"评论数"];
    [self.contentView addSubview:self.hotImageView];
    [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.descLabel.mas_bottom).offset(kSpace);
        make.leading.equalTo(mySelf.descLabel.mas_leading);
       
        make.width.mas_equalTo(kSpace + 5);
        make.height.mas_equalTo(kSpace + 5);
        
    }];
    
    // 评论数
    self.hotLabel = [[UILabel alloc] init];
    self.hotLabel.font = [UIFont systemFontOfSize:12];
    [self.hotLabel NightWithType:UIViewColorTypeNormal];
    [self.hotLabel NightTextType:LabelColorBlack];
    [self.contentView addSubview:self.hotLabel];
    self.hotLabel.text = @"4.3万";
//    [self.hotLabel sizeToFit];
    self.hotLabel.textColor = [UIColor lightGrayColor];
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.descLabel.mas_bottom).offset(kSpace);
        make.left.equalTo(mySelf.hotImageView.mas_right).offset(kSpace);
        make.width.mas_equalTo(kSpace * 5);
        
    }];
    
    // 时间图片
    self.utimeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.utimeImageView];
    self.utimeImageView.image = [UIImage imageNamed:@"时间"];
    [self.utimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mySelf.descLabel.mas_bottom).offset(kSpace + 2);
        make.left.equalTo(mySelf.hotLabel.mas_right).offset(kSpace);
        make.width.equalTo(mySelf.hotImageView.mas_width);
        make.height.equalTo(mySelf.hotImageView.mas_height);
        
    }];
    
    // 时间
    self.utimeLabel = [[UILabel alloc] init];
    self.utimeLabel.font = [UIFont systemFontOfSize:13];
    [self.utimeLabel NightWithType:UIViewColorTypeNormal];
    [self.utimeLabel NightTextType:LabelColorBlack];
    self.utimeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.utimeLabel];
    [self.utimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.descLabel.mas_bottom).offset(kSpace);
        make.left.equalTo(mySelf.utimeImageView.mas_right).offset(kSpace);
        make.right.equalTo(mySelf.contentView).offset(-kSpace);
        
    }];
    
   
    
    
}

@end
