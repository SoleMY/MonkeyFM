//
//  AboutUsCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AboutUsCell.h"

@implementation AboutUsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    __weak typeof(self) mySelf = self;
   self.myImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.contentView).offset(20);
//        make.left.equalTo(mySelf.contentView).offset(20);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width / 2 - 40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    self.myLabel = [[UILabel alloc] init];
    [ self.myLabel sizeToFit];
     self.myLabel.numberOfLines = 0;
    [self.contentView addSubview: self.myLabel];
    [ self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.myImageView.mas_bottom).offset(20);
        make.left.equalTo(mySelf.contentView).offset(10);
        make.right.equalTo(mySelf.contentView).offset(-10);
    }];
}

@end
