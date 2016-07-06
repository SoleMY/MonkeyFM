//
//  SettingTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell ()



@end

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
#warning 夜间模式
        [self.contentView NightWithType:UIViewColorTypeNormal];
    }
    return self;
}

- (void)initLayout
{
    __weak typeof(self) weakSelf = self;
    UILabel *leftTextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:leftTextLabel];
    [leftTextLabel NightWithType:UIViewColorTypeNormal];
    [leftTextLabel NightTextType:LabelColorBlack];
    self.leftTextLabel = leftTextLabel;
    
    [self.leftTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.width.mas_equalTo(200);
    }];
    
    UISwitch *rightSwitch = [[UISwitch alloc] init];
    rightSwitch.onTintColor = kNavigationBarTintColor;
    [rightSwitch addTarget:self action:@selector(openOrCloseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightSwitch];
    self.rightSwitch = rightSwitch;
    
    [self.rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-16);
        make.top.equalTo(weakSelf.contentView).offset(7);
        
    }];
}


- (void)openOrCloseAction
{
    
}




@end
