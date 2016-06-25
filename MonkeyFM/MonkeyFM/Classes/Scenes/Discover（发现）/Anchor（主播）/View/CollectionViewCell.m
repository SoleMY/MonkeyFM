//
//  CollectionViewCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "CollectionViewCell.h"
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
//        self.restorationIdentifier = @"identifier_cell";
//        self.backgroundColor = [UIColor clearColor];
//        self.autoresizingMask = UIViewAutoresizingNone;
//        
//        CGFloat borderWidth = 0.5f;
//        //        UIView *bgView = [[UIView alloc] initWithFrame:frame];
//        //        bgView.layer.borderColor = [UIColor redColor].CGColor;
//        //        bgView.layer.borderWidth = borderWidth;
//        //        self.selectedBackgroundView = bgView;
//        
//        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
//        
//        self.myContentView = [[UIView alloc] initWithFrame:myContentRect];
//        _myContentView.backgroundColor = [UIColor whiteColor];
//        _myContentView.layer.borderColor = [UIColor colorWithWhite:0.1f alpha:0.2f].CGColor;
//        _myContentView.layer.borderWidth = borderWidth;
//        
//        [self.contentView addSubview:_myContentView];
        [self initLayout];

    }
    return self;
}

- (void)initLayout {
    self.headPortrait = [[UIImageView alloc]init];
    self.headPortrait.frame = CGRectMake(10, 0, kHeadPortraitWidth, kHeadPortraitHeight);
    self.headPortrait.layer.cornerRadius = self.headPortrait.frame.size.width / 2;
    self.headPortrait.layer.masksToBounds = YES;
//    self.headPortrait.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.headPortrait];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNameLabelX, self.headPortrait.frame.size.height + 5, kNameLabelWidth, kNameLabelHeight)];
    self.nameLabel.text = @"主播";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    self.introduction = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + 20 , kIntroductionWidth + 20, kIntroductionHeight)];
    self.introduction.text = @"1234567890";
    self.introduction.font = [UIFont systemFontOfSize:13];
    self.introduction.textColor = [UIColor grayColor];
    self.introduction.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.introduction];
}



@end
