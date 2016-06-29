//
//  CommentCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return  self;
}

- (void)initLayout {
    self.headImage = [[UIImageView alloc] init];
    self.headImage.backgroundColor = [UIColor orangeColor];
    self.headImage.layer.cornerRadius = 15;
    self.headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImage];
    __weak typeof(self)weakSelf = self;
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.contentView).offset(3);
        make.width.mas_offset(30);
        make.height.mas_offset(30);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"夏鸥12345";
    [self.nameLabel sizeToFit];
    self.nameLabel.textColor = [UIColor grayColor];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.headImage.mas_right).offset(3);
//        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"2015-09-30";
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(10);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    self.zanNumber = [[UILabel alloc] init];
    self.zanNumber.textColor = [UIColor grayColor];
    self.zanNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.zanNumber];
    self.zanNumber.text = @"318";
    self.zanNumber.textAlignment = NSTextAlignmentRight;
    [self.zanNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.right.equalTo(weakSelf.contentView).offset(-35);
        make.width.mas_offset(60);
        make.height.mas_offset(20);
    }];
    
    self.zanButton = [[UIButton alloc] init];
    self.zanButton.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.zanButton];
    [self.zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.text = @"我是主播";
    self.commentLabel.backgroundColor = [UIColor grayColor];
    self.commentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.nameLabel).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(-20);
    }];

}




@end


