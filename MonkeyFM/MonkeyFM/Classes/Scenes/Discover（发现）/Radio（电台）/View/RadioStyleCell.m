//
//  RadioStyleCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioStyleCell.h"

#define kLeftImageSize CGSizeMake(100, 100)
#define kHeardImageSize CGSizeMake(24, 20)
#define kAddImageSize CGSizeMake(20, 20)
#define kSpace 10
#define kSmallSpace 5
#define kPlayImageSize CGSizeMake(30, 30)


@implementation RadioStyleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    __weak typeof(self)weakSelf = self;
    
    self.leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kSpace);
        make.left.equalTo(weakSelf.contentView).offset(kSpace);
        make.size.mas_equalTo(kLeftImageSize);
    }];
    
    self.playImageView = [[UIImageView alloc] init];
    self.playImageView.image = [[UIImage imageNamed:@"播放button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.playImageView.tintColor = [UIColor whiteColor];
    [self.leftImageView addSubview:self.playImageView];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.leftImageView.mas_bottom).offset(-kSmallSpace);
        make.right.equalTo(weakSelf.leftImageView.mas_right).offset(-kSmallSpace);
        make.size.mas_equalTo(kPlayImageSize);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"这是标题";
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kSpace * 3);
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(kSpace);
        make.right.equalTo(weakSelf.contentView).offset(-kSpace);
    }];
    
    self.desLabel = [[UILabel alloc] init];
    self.desLabel.text = @"这是详细介绍";
    self.desLabel.textColor = [UIColor darkGrayColor];
    self.desLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(kSmallSpace);
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(kSpace);
        make.right.equalTo(weakSelf.contentView).offset(-kSpace);
    }];
    
    self.heardImageView = [[UIImageView alloc] init];
    self.heardImageView.tintColor = [UIColor darkGrayColor];
    self.heardImageView.image = [[UIImage imageNamed:@"headphones11"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.contentView addSubview:self.heardImageView];
    [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.desLabel.mas_bottom).offset(kSmallSpace);
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(kSpace);
        make.size.mas_equalTo(kHeardImageSize);
    }];
    
    self.listenPeopleNum = [[UILabel alloc] init];
    self.listenPeopleNum.text = @"10.0万";
    self.listenPeopleNum.textColor = [UIColor darkGrayColor];
    self.listenPeopleNum.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:self.listenPeopleNum];
    [self.listenPeopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.heardImageView.mas_top).offset(kSmallSpace / 2);
        make.left.equalTo(weakSelf.heardImageView.mas_right);
        make.width.mas_equalTo(kSpace * 5);
    }];
    
    self.attentionImageView = [[UIImageView alloc] init];
    self.attentionImageView.tintColor = [UIColor darkGrayColor];
    self.attentionImageView.image = [[UIImage imageNamed:@"like67"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.contentView addSubview:self.attentionImageView];
    [self.attentionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.desLabel.mas_bottom).offset(kSmallSpace);
        make.left.equalTo(weakSelf.listenPeopleNum.mas_right).offset(kSpace * 5);
        make.size.mas_equalTo(kAddImageSize);
    }];
    
    self.attentionLabel = [[UILabel alloc] init];
    self.attentionLabel.text = @"45";
    self.attentionLabel.textColor = [UIColor darkGrayColor];
    self.attentionLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:self.attentionLabel];
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.attentionImageView.mas_top).offset(kSmallSpace / 2);
        make.left.equalTo(weakSelf.attentionImageView.mas_right);
        make.width.mas_equalTo(kSpace * 5);
    }];
    
}

@end
