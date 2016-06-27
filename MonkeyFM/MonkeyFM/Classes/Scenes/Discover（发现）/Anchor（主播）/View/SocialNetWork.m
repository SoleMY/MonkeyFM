//
//  SocialNetWork.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SocialNetWork.h"
#import <Masonry.h>

@implementation SocialNetWork

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    self.iconImage.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width / 2;
    self.iconImage.layer.masksToBounds = YES;
}

@end
