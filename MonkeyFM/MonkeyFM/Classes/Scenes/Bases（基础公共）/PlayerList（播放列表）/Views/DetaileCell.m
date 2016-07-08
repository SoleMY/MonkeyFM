//
//  DetaileCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetaileCell.h"

@implementation DetaileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.hostLabel = [[UILabel alloc] init];
    self.hostLabel.text = @"主播:";
//    self.hostLabel.textColor = [UIColor grayColor];
    self.hostLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.hostLabel];
    __weak typeof(self) weakSelf = self;
    [self.hostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(17);
    }];
    [self.hostLabel NightWithType:UIViewColorTypeNormal];
    [self.hostLabel NightTextType:LabelColorGray];
    
    
    self.hostText = [[UILabel alloc] init];
    self.hostText.text = @"小毛炉";
    self.hostText.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.hostText];
    [self.hostText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hostLabel).offset(0);
        make.left.equalTo(weakSelf.hostLabel.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(weakSelf.frame.size.width - 60);
    }];
    [self.hostText NightWithType:UIViewColorTypeNormal];
    [self.hostText NightTextType:LabelColorBlack];
    
    self.sourceLabel = [[UILabel alloc] init];
    self.sourceLabel.text = @"来源";
    self.sourceLabel.font = [UIFont systemFontOfSize:15];
//    self.sourceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.sourceLabel];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hostLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(17);
    }];
    [self.sourceLabel NightWithType:UIViewColorTypeNormal];
    [self.sourceLabel NightTextType:LabelColorGray];
    
    
    self.sourceText = [[UILabel alloc] init];
    self.sourceText.text = @"MonkeyFM";
    self.sourceText.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.sourceText];
    [self.sourceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sourceLabel).offset(0);
        make.left.equalTo(weakSelf.sourceLabel.mas_right).offset(5);
        make.width.mas_offset(weakSelf.frame.size.width - 60);
        make.height.mas_offset(20);
    }];
    [self.sourceText NightWithType:UIViewColorTypeNormal];
    [self.sourceText NightTextType:LabelColorBlack];
    
    
    self.uploadingLabel = [[UILabel alloc] init];
    self.uploadingLabel.text = @"上传";
    self.uploadingLabel.font = [UIFont systemFontOfSize:15];
    self.uploadingLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.uploadingLabel];
    [self.uploadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sourceLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(17);
    }];
    
    [self.uploadingLabel NightWithType:UIViewColorTypeNormal];
    [self.uploadingLabel NightTextType:LabelColorGray];
    
    self.uploadingText = [[UILabel alloc]init];
    self.uploadingText.text =@"王钢蛋";
    self.uploadingText.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.uploadingText];
    [self.uploadingText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.uploadingLabel).offset(0);
        make.left.equalTo(weakSelf.uploadingLabel.mas_right).offset(5);
        make.width.mas_offset(weakSelf.frame.size.width - 60);
        make.height.mas_offset(20);
    }];
    [self.uploadingText NightWithType:UIViewColorTypeNormal];
    [self.uploadingText NightTextType:LabelColorBlack];
    
    
    self.accreditLabel = [[UILabel alloc] init];
    self.accreditLabel.text = @"授权方式";
    self.accreditLabel.textColor = [UIColor grayColor];
    self.accreditLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.accreditLabel];
    [self.accreditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.uploadingLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(70);
        make.height.mas_offset(17);
    }];
    [self.accreditLabel NightWithType:UIViewColorTypeNormal];
    [self.accreditLabel NightTextType:LabelColorGray];
    
    self.accreditText = [[UILabel alloc] init];
    self.accreditText.text = @"原创";
    self.accreditText.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.accreditText];
    [self.accreditText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accreditLabel).offset(0);
        make.left.equalTo(weakSelf.accreditLabel.mas_right).offset(5);
        make.width.mas_offset(weakSelf.frame.size.width - 60);
        make.height.mas_offset(20);
    }];
    [self.accreditText NightWithType:UIViewColorTypeNormal];
    [self.accreditText NightTextType:LabelColorBlack];
    
    self.statuLabel = [[UILabel alloc] init];
    self.statuLabel.text = @"状态";
    self.statuLabel.textColor = [UIColor grayColor];
    self.statuLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.statuLabel];
    [self.statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accreditLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(17);
    }];
    [self.statuLabel NightWithType:UIViewColorTypeNormal];
    [self.statuLabel NightTextType:LabelColorGray];
    
    
    self.statusText = [[UILabel alloc] init];
    self.statusText.text = @"更新中";
    self.statusText.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.statusText];
    [self.statusText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.statuLabel).offset(0);
        make.left.equalTo(weakSelf.statuLabel.mas_right).offset(5);
        make.width.mas_offset(weakSelf.frame.size.width - 60);
        make.height.mas_offset(20);
    }];
    [self.statusText NightWithType:UIViewColorTypeNormal];
    [self.statusText NightTextType:LabelColorBlack];
    
    
}

@end
