//
//  TheHostShow.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "TheHostShow.h"

#define kHeadPortraitWidth 80
#define kHeadPortraitHeight 80
#define kNameLabelX 10
#define kNameLabelY kHeadPortraitHeight + 5
#define kNameLabelWidth kHeadPortraitWidth
#define kNameLabelHeight 20
#define kIntroductionWidth kHeadPortraitWidth
#define kIntroductionHeight 17

@implementation TheHostShow

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.headPortrait = [[UIImageView alloc]init];
    self.headPortrait.frame = CGRectMake(10, 0, kHeadPortraitWidth, kHeadPortraitHeight);
    self.headPortrait.layer.cornerRadius = self.headPortrait.frame.size.width / 2;
    self.headPortrait.layer.masksToBounds = YES;
    self.headPortrait.backgroundColor = [UIColor redColor];
    [self addSubview:self.headPortrait];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNameLabelX, self.headPortrait.frame.size.height + 5, kNameLabelWidth, kNameLabelHeight)];
    self.nameLabel.text = @"主播";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    self.introduction = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + 20 , kIntroductionWidth + 20, kIntroductionHeight)];
    self.introduction.text = @"1234567890";
    self.introduction.font = [UIFont systemFontOfSize:13];
    self.introduction.textColor = [UIColor grayColor];
    self.introduction.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.introduction];
}

@end
