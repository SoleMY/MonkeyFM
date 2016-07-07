//
//  HostViewDetaileCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HostViewDetaileCell.h"
#define kImageHeight 80
#define kImageWidth 80
#define kNameLabelHeight 25

@implementation HostViewDetaileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    __weak typeof(self) mySelf = self;
    self.headImage = [[UIImageView alloc] init];
    self.headImage.layer.cornerRadius = kImageWidth / 2;
    self.headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(10);
        make.left.equalTo(mySelf.contentView).offset(5);
        make.height.mas_offset(kImageHeight);
        make.width.mas_offset(kImageWidth);
    }];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"空空";
    self.nameLabel.textColor = kNavigationBarTintColor;
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(12);
        make.left.equalTo(mySelf.headImage.mas_right).offset(10);
        make.right.equalTo(mySelf.contentView).offset(5);
        make.height.mas_offset(kNameLabelHeight);
    }];
#warning 夜间模式改动
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    
    self.decLabel = [[UILabel alloc] init];
    self.decLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.decLabel];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.nameLabel.mas_bottom).offset(1);
        make.left.equalTo(mySelf.headImage.mas_right).offset(10);
        make.width.mas_offset(150);
        make.height.mas_offset(kNameLabelHeight);
    }];
    
#warning 夜间模式改动
    [self.decLabel NightWithType:UIViewColorTypeNormal];
    [self.decLabel NightTextType:LabelColorBlack];
    
    self.fansNumber = [[UILabel alloc] init];
    self.fansNumber.font = [UIFont systemFontOfSize:12];
//    self.fansNumber.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.fansNumber];
    [self.fansNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.decLabel.mas_bottom).offset(1);
        make.left.equalTo(mySelf.headImage.mas_right).offset(10);
        make.width.mas_offset(150);
        make.height.mas_offset(kNameLabelHeight);
    }];
#warning 夜间模式改动
    [self.fansNumber NightWithType:UIViewColorTypeNormal];
    [self.fansNumber NightTextType:LabelColorGray];
    
    self.followButton = [[UIButton alloc] init];

    [self.followButton setImage:[UIImage imageNamed:@"chat_support_green@2x"] forState:UIControlStateNormal];
    self.followButton.tintColor = kNavigationBarTintColor;
    [self.contentView addSubview:self.followButton];
     [self.followButton addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(30);
        make.right.equalTo(mySelf.contentView).offset(-15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}


- (void)followAction {
    NSLog(@"====");
}

@end
