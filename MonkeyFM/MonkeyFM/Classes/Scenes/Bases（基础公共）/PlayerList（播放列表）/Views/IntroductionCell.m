//
//  IntroductionCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "IntroductionCell.h"

@implementation IntroductionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.introductionLabel = [[UILabel alloc] init];
    self.introductionLabel.textColor = [UIColor grayColor];
    self.introductionLabel.font = [UIFont systemFontOfSize:13];
    self.introductionLabel.text = @"简介";
    [self.contentView addSubview:self.introductionLabel];
    __weak typeof(self)mySelf = self;
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(5);
        make.left.equalTo(mySelf.contentView).offset(5);
        make.width.mas_offset(70);
        make.height.mas_offset(25);
    }];
    [self.introductionLabel NightWithType:UIViewColorTypeNormal];
    [self.introductionLabel NightTextType:LabelColorBlack];
    
    self.introductionText = [[UILabel alloc] init];
    self.introductionText.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.introductionText];
    self.introductionText.text = @"脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀脱口秀";
    self.introductionText.numberOfLines = 0;
    [self.introductionText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.introductionLabel.mas_bottom).offset(5);
        make.left.equalTo(mySelf.introductionLabel).offset(5);
        make.width.mas_offset([UIScreen mainScreen].bounds.size.width - 15);
    }];
    [self.introductionText NightWithType:UIViewColorTypeNormal];
    [self.introductionText NightTextType:LabelColorBlack];
    
}

@end
