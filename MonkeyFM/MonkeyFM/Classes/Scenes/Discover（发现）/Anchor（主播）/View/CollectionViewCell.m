//
//  CollectionViewCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "CollectionViewCell.h"

#import "RadioModel.h"
#import "Host.h"

#define kHeadPortraitWidth 80
#define kHeadPortraitHeight 80
#define kNameLabelX 10
#define kNameLabelY kHeadPortraitHeight + 5
#define kNameLabelWidth kHeadPortraitWidth
#define kNameLabelHeight 20
#define kIntroductionWidth kHeadPortraitWidth
#define kIntroductionHeight 17
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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
    [self.contentView addSubview:self.headPortrait];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNameLabelX, self.headPortrait.frame.size.height + 5, kNameLabelWidth, kNameLabelHeight)];
    self.nameLabel.text = @"主播";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
#warning 夜间模式改动
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    [self.contentView addSubview:self.nameLabel];
    
    self.introduction = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + 20 , kIntroductionWidth + 20, kIntroductionHeight)];
    self.introduction.text = @"1234567890";
    self.introduction.font = [UIFont systemFontOfSize:13];
    self.introduction.textColor = [UIColor grayColor];
    self.introduction.textAlignment = NSTextAlignmentCenter;
#warning 夜间模式改动
    [self.introduction NightWithType:UIViewColorTypeNormal];
    [self.introduction NightTextType:LabelColorGray];
    
    [self.contentView addSubview:self.introduction];
}

- (void)bindRecommendModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = model.dataList[indexPath.row];
    Host *host = [[Host alloc] init];
    [host setValuesForKeysWithDictionary:dic];
    self.nameLabel.text = host.nickName;
#warning 夜间模式改动
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    
    self.introduction.text = host.recommendReson;
#warning 夜间模式改动
    [self.introduction NightWithType:UIViewColorTypeNormal];
    [self.introduction NightTextType:LabelColorGray];
    [self.headPortrait sd_setImageWithURL:[NSURL URLWithString:host.avatar]];
}

- (void)bindPopularModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = model.dataList[indexPath.row];
    Host *host = [[Host alloc] init];
    [host setValuesForKeysWithDictionary:dic];
    self.nameLabel.text = host.rname;
#warning 夜间模式改动
    
    [self.nameLabel NightTextType:LabelColorBlack];
    self.nameLabel.frame = CGRectMake(10, 0, kNameLabelWidth, kNameLabelHeight);
    self.nameLabel.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    self.introduction.text = nil;
    [self.headPortrait sd_setImageWithURL:[NSURL URLWithString:host.pic]];
}


@end
