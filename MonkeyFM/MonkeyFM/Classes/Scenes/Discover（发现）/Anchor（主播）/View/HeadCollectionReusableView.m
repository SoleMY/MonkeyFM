//
//  HeadCollectionReusableView.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HeadCollectionReusableView.h"

@implementation HeadCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    self.titleLabel.text = @"TAde";
    [self.titleLabel NightWithType:UIViewColorTypeNormal];
    [self.titleLabel NightTextType:LabelColorBlack];
    [self addSubview:self.titleLabel];
    self.more = [[UIButton alloc] init];
    self.more.frame = CGRectMake(self.frame.size.width - 80, 0, 60, 30);
    [self addSubview:self.more];
}

@end
