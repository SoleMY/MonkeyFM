//
//  ClassificationCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ClassificationCell.h"
#import <Masonry.h>
@implementation ClassificationCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 布局子视图
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    // 创建对象
    self.photoImage = [[UIImageView alloc] init];
    
//    self.photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 4 * 3)];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 4 * 3, self.bounds.size.width, self.bounds.size.height / 4)];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.photoImage];
    [self.contentView addSubview:self.label];
    __weak typeof(self)mySelf = self;
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mySelf.label);
        make.bottom.equalTo(mySelf.label.mas_top).offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    
}
@end
