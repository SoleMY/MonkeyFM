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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(3);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(80);
        make.height.mas_offset(25);
    }];
    
    self.listen = [[UIImageView alloc] init];
    self.listen.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.listen];
    [self.listen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.titleLabel).offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    self.listenNumber = [[UILabel alloc] init];
    self.listenNumber.text = @"2903";
    self.listenNumber.font = [UIFont systemFontOfSize:13];
    self.listenNumber.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.listenNumber];
    [self.listenNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.listen).offset(0);
        make.left.equalTo(self.listen.mas_right).offset(3);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    
    self.like = [[UIImageView alloc] init];
    self.like.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.like];
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.listen).offset(0);
        make.left.equalTo(self.listenNumber.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.likeNumber = [[UILabel alloc] init];
    self.likeNumber.text = @"4";
    self.likeNumber.textColor = [UIColor grayColor];
    self.likeNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.likeNumber];
    [self.likeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.like).offset(0);
        make.left.equalTo(self.like.mas_right).offset(3);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    
    self.comment = [[UIImageView alloc] init];
    self.comment.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.comment];
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeNumber).offset(0);
        make.left.equalTo(self.likeNumber.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.commentNumber = [[UILabel alloc] init];
    self.commentNumber.text = @"1";
    self.commentNumber.font = [UIFont systemFontOfSize:13];
    self.commentNumber.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.commentNumber];
    [self.commentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comment).offset(0);
        make.left.equalTo(self.comment.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"2016-06-17";
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentNumber).offset(0);
        make.left.equalTo(self.commentNumber.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(80);
    }];
    
}


@end
