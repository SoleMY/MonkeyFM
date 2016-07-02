//
//  KeywordsCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "KeywordsCell.h"
#import "SmallTools.h"
#import "PlayList.h"
@implementation KeywordsCell
@synthesize buttonArray = _buttonArray;

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

//- (NSMutableArray *)numberOfButton {
//    if (!_numberOfButton) {
//        _numberOfButton = [NSMutableArray array];
//    }
//    return _numberOfButton;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)setButtonArray:(NSMutableArray *)buttonArray
{
    if (_buttonArray != buttonArray) {
        _buttonArray = buttonArray;
    }
    [self initLayout];
}

- (void)initLayout {
    self.keywordLabel = [[UILabel alloc] init];
    self.keywordLabel.textColor = [UIColor grayColor];
    self.keywordLabel.font = [UIFont systemFontOfSize:13];
    self.keywordLabel.text = @"关键字：";
    [self.contentView addSubview:self.keywordLabel];
    [self.keywordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_offset(70);
    }];
    int j = 1;
    for (int i = 0; i < self.buttonArray.count; i++) {
//        创建button
        UIButton *button = [[UIButton alloc] init];
        [self.arr addObject:button];
//        背景颜色
        button.backgroundColor = [UIColor orangeColor];
//        字
        [button setTitle:self.buttonArray[i] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
//        计算宽度
        CGFloat width = [SmallTools textWidthWithText:self.buttonArray[i] font:[UIFont systemFontOfSize:13]];
        if (i != 0) {
            CGFloat upWidth = [SmallTools textWidthWithText:self.buttonArray[i - 1] font:[UIFont systemFontOfSize:13]];
            UIButton *arrButton = self.arr[i - 1];
        if (arrButton.frame.origin.x + upWidth + width  + 40 > [UIScreen mainScreen].bounds.size.width) {
                button.frame = CGRectMake(90, j * 40 + 10, width + 10, 25);
                j++;
        }else {
            button.frame = CGRectMake( arrButton.frame.origin.x + upWidth + 20, 40 * (j - 1) + 10, width + 10, 25);
        }
        [self.contentView addSubview:button];
        } else {
            button.frame = CGRectMake(90, 10, width + 10, 25);
            [self.contentView addSubview:button];
        }
    }
    _numberOfButton = j;
}


@end
