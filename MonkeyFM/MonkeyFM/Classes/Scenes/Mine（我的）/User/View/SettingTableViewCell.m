//
//  SettingTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "SystemLight.h"

@interface SettingTableViewCell ()



@end

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
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
    
    UISwitch *nightSwitch = [[UISwitch alloc] init];
    if ([ThemeManage shareThemeManage].isNight) {
        nightSwitch.on = YES;
    } else {
        nightSwitch.on = NO;
    }
    
    [nightSwitch addTarget:self action:@selector(openOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:nightSwitch];
    self.nightSwitch = nightSwitch;
    self.nightSwitch.onTintColor = [UIColor darkGrayColor];
    [self.nightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-16);
        make.top.equalTo(weakSelf.contentView).offset(7);
    }];
}


- (void)openOrCloseAction:(UISwitch *)sender
{
    if (self.status == isUseing) {
        
    } else if (self.status == isNight) {
        if (sender.isOn) {
            [SystemLight shareSystemLight].currentLight = [UIScreen mainScreen].brightness;
            [ThemeManage shareThemeManage].isNight = YES;
            [UIScreen mainScreen].brightness = 0.2;
        } else {
            [ThemeManage shareThemeManage].isNight = NO;
            [UIScreen mainScreen].brightness = [SystemLight shareSystemLight].currentLight;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
        [[NSUserDefaults standardUserDefaults] setBool:[ThemeManage shareThemeManage].isNight forKey:@"night"];
    }
}

@end
