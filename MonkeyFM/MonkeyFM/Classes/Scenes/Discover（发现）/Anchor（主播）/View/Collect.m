//
//  Collect.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "Collect.h"
#define kPictureWidth 40
#define kPictureHeight 40

#define kTitleLabelWidth 200
#define kTitleLabelHeight 15
@implementation Collect

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.picture = [[UIImageView alloc] init];
//    self.picture.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.picture];
    __weak typeof(self)mySelf = self;
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(5);
        make.left.equalTo(mySelf.contentView).offset(5);
        make.width.mas_offset(kPictureWidth);
        make.height.mas_offset(kPictureHeight);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
//    self.titleLabel.backgroundColor = [UIColor grayColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(5);
        make.left.equalTo(mySelf.picture.mas_right).offset(5);
        make.height.mas_offset(kTitleLabelHeight);
        make.width.mas_offset(kTitleLabelWidth);
    }];
    
    self.decLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.decLabel];
    self.decLabel.font = [UIFont systemFontOfSize:13];
    self.decLabel.textColor = [UIColor grayColor];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(mySelf.picture.mas_right).offset(5);
        make.height.mas_offset(kTitleLabelHeight);
        make.width.mas_offset(kTitleLabelWidth);
    }];
    
    self.dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor grayColor];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.titleLabel.mas_bottom).offset(0);
        make.right.equalTo(mySelf.contentView).offset(-20);
        make.width.mas_offset(80);
        make.height.mas_offset(kTitleLabelHeight);
    }];
    
    
}
@end
