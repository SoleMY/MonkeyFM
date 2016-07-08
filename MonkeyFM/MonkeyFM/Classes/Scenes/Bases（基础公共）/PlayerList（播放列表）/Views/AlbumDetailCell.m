
//
//  AlbumDetailCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AlbumDetailCell.h"
#import "PlayList.h"
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
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.titleLabel];
    __weak typeof(self)weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    
    [self.titleLabel NightWithType:UIViewColorTypeNormal];
    [self.titleLabel NightTextType:LabelColorGray];
    
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
    [self.firstLabel NightWithType:UIViewColorTypeNormal];
    [self.firstLabel NightTextType:LabelColorBlack];
    
    
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
    [self.secondLabel NightWithType:UIViewColorTypeNormal];
    [self.secondLabel NightTextType:LabelColorBlack];
    
    
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
    [self.thiredLabel NightWithType:UIViewColorTypeNormal];
    [self.thiredLabel NightTextType:LabelColorBlack];
    
}

- (void)bindWithArray:(NSMutableArray *)array {
    if (array.count == 3) {
        PlayList *playList1 = array[0];
         PlayList *playList2 = array[1];
         PlayList *playList3 = array[2];
        self.firstLabel.text = playList1.name;
        self.secondLabel.text = playList2.name;
        self.thiredLabel.text = playList3.name;
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:playList1.img]];
        [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:playList2.img]];
        [self.thiredImageView sd_setImageWithURL:[NSURL URLWithString:playList3.img]];

    }
}

@end
