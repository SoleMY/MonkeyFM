//
//  ProgramCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ProgramCell.h"

@implementation ProgramCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"第一期";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    __weak typeof(self)weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(3);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-20);
        make.height.mas_offset(25);
    }];
    
    [self.titleLabel NightWithType:UIViewColorTypeNormal];
    [self.titleLabel NightTextType:LabelColorBlack];
    
    self.listen = [[UIImageView alloc] init];
//    self.listen.backgroundColor = [UIColor orangeColor];
    self.listen.image = [UIImage imageNamed:@"icon_listen"];
    [self.contentView addSubview:self.listen];
    [self.listen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.titleLabel).offset(0);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];

    
    self.listenNumber = [[UILabel alloc] init];
    self.listenNumber.text = @"2903";
    self.listenNumber.font = [UIFont systemFontOfSize:13];
    self.listenNumber.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.listenNumber];
    [self.listenNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.listen).offset(0);
        make.left.equalTo(weakSelf.listen.mas_right).offset(3);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    [self.listenNumber NightWithType:UIViewColorTypeNormal];
    [self.listenNumber NightTextType:LabelColorGray];
    
    self.like = [[UIImageView alloc] init];
//    self.like.backgroundColor = [UIColor orangeColor];
    self.like.image = [UIImage imageNamed:@"icon_detail_attention@2x"];
    [self.contentView addSubview:self.like];
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.listen).offset(0);
        make.left.equalTo(weakSelf.listenNumber.mas_right).offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    
    
    self.likeNumber = [[UILabel alloc] init];
    self.likeNumber.text = @"4";
    self.likeNumber.textColor = [UIColor grayColor];
    self.likeNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.likeNumber];
    [self.likeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.like).offset(0);
        make.left.equalTo(weakSelf.like.mas_right).offset(3);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    [self.likeNumber NightWithType:UIViewColorTypeNormal];
    [self.likeNumber NightTextType:LabelColorGray];
    
    self.comment = [[UIImageView alloc] init];
//    self.comment.backgroundColor = [UIColor orangeColor];
    self.comment.image = [UIImage imageNamed:@"icon_radiodetail_arrowup@2x"];
    [self.contentView addSubview:self.comment];
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeNumber).offset(0);
        make.left.equalTo(weakSelf.likeNumber.mas_right).offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.commentNumber = [[UILabel alloc] init];
    self.commentNumber.text = @"1";
    self.commentNumber.font = [UIFont systemFontOfSize:13];
    self.commentNumber.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.commentNumber];
    [self.commentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.comment).offset(0);
        make.left.equalTo(weakSelf.comment.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    [self.commentNumber NightWithType:UIViewColorTypeNormal];
    [self.commentNumber NightTextType:LabelColorGray];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"2016-06-17";
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.commentNumber).offset(0);
        make.left.equalTo(weakSelf.commentNumber.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(80);
    }];
    [self.dateLabel NightWithType:UIViewColorTypeNormal];
    [self.dateLabel NightTextType:LabelColorGray];
    
}

- (void)bindWithModel:(PlayList *)playList {
    NSString *str = [NSString stringWithFormat:@"%ld期：%@", playList.orderNum, playList.audioName];
    self.titleLabel.text = str;
    NSString *listenNum = [NSString stringWithFormat:@"%ld", playList.listenNum];
    self.listenNumber.text = listenNum;
    NSString *likeNum = [NSString stringWithFormat:@"%ld",playList.likedNum];
    self.likeNumber.text = likeNum;
    NSString *commentNum = [NSString stringWithFormat:@"%ld", playList.commentNum];
    self.commentNumber.text = commentNum;
    self.dateLabel.text = playList.updateTime;
}


@end
