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
    self.hostLabel.textColor = [UIColor grayColor];
    self.hostLabel.font = [UIFont systemFontOfSize:15];
    __weak typeof(self) weakSelf = self;
    [self.hostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.contentView).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(17);
    }];
    
    self.hostText = [[UILabel alloc] init];
    self.hostText.text = @"小毛炉";
    [self.contentView addSubview:self.hostText];
    [self.hostText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.left.equalTo(weakSelf.hostLabel.mas_right).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(weakSelf.frame.size.width - 60);
    }];
    
    self.sourceLabel = [[UILabel alloc] init];
    self.sourceLabel.text = @"来源";
    self.sourceLabel.font = [UIFont systemFontOfSize:15];
    self.sourceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.sourceLabel];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hostLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(17);
    }];
    
    self.sourceText = [[UILabel alloc] init];
    self.sourceText.text = @"MonkeyFM";
    [self.contentView addSubview:self.sourceText];
//    [self.sourceText mas_makeConstraints:<#^(MASConstraintMaker *make)block#>]
    
}

@end
