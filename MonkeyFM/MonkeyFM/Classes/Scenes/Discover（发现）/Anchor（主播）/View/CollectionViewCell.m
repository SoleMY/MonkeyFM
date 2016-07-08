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
    [self.nameLabel NightWithType:UIViewColorTypeNormal];
    [self.nameLabel NightTextType:LabelColorBlack];
    [self.contentView addSubview:self.nameLabel];
    
    self.introduction = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + 20 , kIntroductionWidth + 20, kIntroductionHeight)];
    self.introduction.text = @"1234567890";
    self.introduction.font = [UIFont systemFontOfSize:13];
    self.introduction.textColor = [UIColor grayColor];
    self.introduction.textAlignment = NSTextAlignmentCenter;
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
    
    self.introduction.text = host.recommendReson;
    [self.headPortrait sd_setImageWithURL:[NSURL URLWithString:host.avatar]];
}

- (void)bindPopularModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = model.dataList[indexPath.row];
    Host *host = [[Host alloc] init];
    [host setValuesForKeysWithDictionary:dic];
    self.nameLabel.text = host.rname;
    self.introduction.text = nil;
    [self.headPortrait sd_setImageWithURL:[NSURL URLWithString:host.pic]];
}


@end
