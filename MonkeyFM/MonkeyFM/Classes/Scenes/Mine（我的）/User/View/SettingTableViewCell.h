//
//  SettingTableViewCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"


typedef NS_ENUM(NSUInteger, status) {
    isUseing,
    isNight,
};
@interface SettingTableViewCell : BaseCell

@property (nonatomic, strong) UILabel *leftTextLabel;
@property (nonatomic, strong) UISwitch *rightSwitch;
@property (nonatomic, assign) status status;

@end
