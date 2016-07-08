//
//  HeadImage.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/26.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HeadImage.h"

#define kBgImageViewHeight 150
@implementation HeadImage

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    __weak typeof(self)weakSelf = self;
    self.nameLabel.text = @"空空道人厚黑堂";
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(55);
        make.left.equalTo(weakSelf.contentView).offset([UIScreen mainScreen].bounds.size.width / 2 - 75);
        make.width.mas_offset(150);
        make.height.mas_offset(25);
    }];
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    
    self.followButton = [[UIButton alloc] init];
//    self.followButton.backgroundColor = [UIColor redColor];
    [self.followButton setImage:[UIImage imageNamed:@"ico_attention@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.nameLabel.mas_left).offset(-40);
        make.width.mas_offset(80);
        make.height.mas_offset(25);
    }];

    
    self.messageButton = [[UIButton alloc] init];
//    self.messageButton.backgroundColor = [UIColor redColor];
    [self.messageButton setImage:[UIImage imageNamed:@"ico_letter@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.messageButton];
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(-40);
        make.width.mas_offset(80);
        make.height.mas_offset(25);
    }];
    
    self.followNumber = [[UILabel alloc] init];
    self.followNumber.text = @"2";
    self.followNumber.textAlignment = NSTextAlignmentCenter;
    self.followNumber.textColor = [UIColor grayColor];
    self.followNumber.font = [UIFont systemFontOfSize:15];
    self.followNumber.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.followNumber];
    [self.followNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.followButton.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.followButton).offset(15);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
    }];
    [self.followNumber NightWithType:UIViewColorTypeNormal];
    [self.followNumber NightTextType:LabelColorGray];
    
    self.fansNumber = [[UILabel alloc] init];
    self.fansNumber.text = @"13000";
//    self.fansNumber.textColor = [UIColor grayColor];
    self.fansNumber.font = [UIFont systemFontOfSize:15];
    self.fansNumber.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.fansNumber];
    [self.fansNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.followButton.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.messageButton).offset(15);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
    }];
    [self.fansNumber NightWithType:UIViewColorTypeNormal];
    [self.fansNumber NightTextType:LabelColorGray];
    
    self.followText = [[UILabel alloc] init];
//    self.followText.textColor = [UIColor grayColor];
    self.followText.text = @"关注";
    self.followText.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.followText];
    [self.followText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.followNumber.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.followNumber.mas_left).offset(10);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
    }];
    [self.followText NightWithType:UIViewColorTypeNormal];
    [self.followText NightTextType:LabelColorGray];
    self.fansText = [[UILabel alloc] init];
    self.fansText.text = @"粉丝";
    self.fansText.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.fansText];
    [self.fansText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fansNumber.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.fansNumber.mas_left).offset(10);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
    }];
    [self.fansText NightWithType:UIViewColorTypeNormal];
    [self.fansText NightTextType:LabelColorGray];
    
}

@end
