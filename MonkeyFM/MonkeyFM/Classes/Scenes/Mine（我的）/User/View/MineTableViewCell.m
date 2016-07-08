//
//  MineTableViewCell.m
//  Mine
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 孟令旭. All rights reserved.
//

#import "MineTableViewCell.h"
#import "Masonry.h"
#define kSpace 10
#define imageWidth 30
#define cellHeightAndSpace [UIScreen mainScreen].bounds.size.width - 130


@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    self.pic = [[UIImageView alloc] init];
    self.pic.image = [UIImage imageNamed:@"4-140R1102943.jpg"];
    [self.contentView addSubview:self.pic];
    __weak typeof(self)mySelf = self;
    [self.pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf.contentView).offset(kSpace);
        make.left.offset(kSpace);
        make.bottom.equalTo(mySelf.contentView).offset(-kSpace);
        make.width.equalTo(mySelf.pic.mas_height);
    }];
    // 图片上的button
    self.button = [[UIImageView alloc] init];
    self.button.image = [UIImage imageNamed:@"播放button"];
    [self.pic addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageWidth);
        make.bottom.equalTo(mySelf.pic.mas_bottom).offset(-kSpace);
        make.right.equalTo(mySelf.pic.mas_right).offset(-kSpace);
    }];
    
    // title
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"qr";
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    

    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mySelf.pic.mas_top).offset(1.5*kSpace);
        make.left.equalTo(mySelf.pic.mas_right).offset(kSpace);
        make.width.mas_equalTo(cellHeightAndSpace);
    }];
    
    // 内容
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.text = @"werwer";
    [self.descLabel NightWithType:UIViewColorTypeNormal];
    [self.descLabel NightTextType:LabelColorBlack];
    
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mySelf.nameLabel.mas_bottom).offset(10);
        // 左对齐
        make.leading.equalTo(mySelf.nameLabel.mas_leading);
        // 右对齐
        make.width.mas_equalTo(cellHeightAndSpace);
        
    }];
    
    self.utimeLabel = [[UILabel alloc] init];
    self.utimeLabel.text = @"19分钟前";
    self.utimeLabel.textColor = [UIColor lightGrayColor];
    self.utimeLabel.textAlignment = NSTextAlignmentRight;
    self.utimeLabel.text = @"3434234";
    [self.utimeLabel NightWithType:UIViewColorTypeNormal];
    [self.utimeLabel NightTextType:LabelColorBlack];
    [self.contentView addSubview:self.utimeLabel];
    [self.utimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(mySelf.contentView).offset(-10);
//        make.trailing.equalTo(mySelf.descLabel);
        make.right.equalTo(mySelf.contentView.mas_right).offset(-5);
        make.width.mas_equalTo(130);
        NSLog(@"111");
    }];
    
}


- (void)cellBindWithObject:(AVObject *)object {
    self.nameLabel.text = [object objectForKey:@"name"];
    self.descLabel.text = @"";
    self.utimeLabel.text = [object objectForKey:@"updateDay"];
    NSString *picURL = [object objectForKey:@"pic"];
    [self.pic sd_setImageWithURL:[NSURL URLWithString:picURL]];
}

@end
