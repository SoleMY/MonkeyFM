//
//  RadioContentCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioContentCell.h"
#import "RadioModel.h"

@implementation RadioContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 布局视图
        [self initLayout];
    }
    return self;
}

// 布局视图
- (void)initLayout
{
    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 6, 0, self.bounds.size.width * 2 / 3, self.bounds.size.height * 2 / 3)];
    self.topImageView.layer.cornerRadius = self.bounds.size.width / 3;
    self.topImageView.tintColor = kControlTintColor;
    [self.contentView addSubview:self.topImageView];
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 2 / 3, self.bounds.size.width, self.bounds.size.height / 3)];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomLabel NightWithType:UIViewColorTypeNormal];
    [self.bottomLabel NightTextType:LabelColorBlack];
    [self.contentView addSubview:self.bottomLabel];
}


- (void)bindModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [model.dataList firstObject];
    NSArray *nameArray = [dic objectForKey:@"dataList"];
    self.bottomLabel.text = [nameArray[indexPath.row] objectForKey:@"name"];
    self.topImageView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", self.bottomLabel.text]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
@end
