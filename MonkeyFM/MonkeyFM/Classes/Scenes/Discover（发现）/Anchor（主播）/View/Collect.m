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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(5);
        make.left.equalTo(mySelf.picture.mas_right).offset(5);
        make.height.mas_offset(kTitleLabelHeight);
        make.width.mas_offset(kTitleLabelWidth);
    }];
#warning 夜间模式改动
    [self.titleLabel NightWithType:UIViewColorTypeNormal];
    [self.titleLabel NightTextType:LabelColorBlack];
    
    self.decLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.decLabel];
    self.decLabel.font = [UIFont systemFontOfSize:13];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(mySelf.picture.mas_right).offset(5);
        make.height.mas_offset(kTitleLabelHeight);
        make.width.mas_offset(kTitleLabelWidth);
    }];
#warning 夜间模式改动
    [self.decLabel NightWithType:UIViewColorTypeNormal];
    [self.decLabel NightTextType:LabelColorGray];
    
    self.dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.titleLabel.mas_bottom).offset(0);
        make.right.equalTo(mySelf.contentView).offset(-20);
        make.width.mas_offset(80);
        make.height.mas_offset(kTitleLabelHeight);
    }];
#warning 夜间模式改动
    [self.dateLabel NightWithType:UIViewColorTypeNormal];
    [self.dateLabel NightTextType:LabelColorGray];
    
}
@end
