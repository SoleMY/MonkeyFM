//
//  HostViewDetaileCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HostViewDetaileCell.h"
#import <Masonry.h>
#import "SmallTools.h"
#define kImageHeight 100
#define kImageWidth 100
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
    self.headImage.backgroundColor = [UIColor greenColor];
    self.headImage.layer.cornerRadius = 50;
    self.headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(5);
        make.left.equalTo(mySelf.contentView).offset(5);
        make.height.mas_offset(kImageHeight);
        make.width.mas_offset(kImageWidth);
    }];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"空空";
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(5);
        make.left.equalTo(mySelf.headImage.mas_right).offset(10);
        make.right.equalTo(mySelf.contentView).offset(5);
        make.height.mas_offset(kNameLabelHeight);
    }];
    
    self.decLabel = [[UILabel alloc] init];
    self.decLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.decLabel];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(mySelf.headImage.mas_right).offset(10);
        make.width.mas_offset(150);
        make.height.mas_offset(kNameLabelHeight);
    }];
    
    self.fansNumber = [[UILabel alloc] init];
    self.fansNumber.text = @"123";
    [self.contentView addSubview:self.fansNumber];
    [self.fansNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.decLabel.mas_bottom).offset(5);
        make.left.equalTo(mySelf.headImage.mas_right).offset(10);
        make.width.mas_offset(150);
        make.height.mas_offset(kNameLabelHeight);
    }];
    
    self.followButton = [[UIButton alloc] init];
    UIImage *image = [UIImage imageNamed:@"addAttention@3x"];
    image = [SmallTools scaleToSize:image size:CGSizeMake(30, 30)];
    [self.followButton setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    self.followButton.backgroundColor = [UIColor grayColor];
    self.followButton.tintColor = [UIColor colorWithRed:46/255.0 green:196/255.0 blue:96/255.0 alpha:1];
    
    [self.contentView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(30);
        make.right.equalTo(mySelf.contentView).offset(-50);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}

@end
