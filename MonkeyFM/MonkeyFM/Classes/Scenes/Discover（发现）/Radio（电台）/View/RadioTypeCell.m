//
//  RadioTypeCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioTypeCell.h"
#import "RadioModel.h"
@implementation RadioTypeCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.restorationIdentifier = @"identifier_typeCell";
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        
        CGFloat borderWidth = 0.5f;
//        UIView *bgView = [[UIView alloc] initWithFrame:frame];
//        bgView.layer.borderColor = [UIColor redColor].CGColor;
//        bgView.layer.borderWidth = borderWidth;
//        self.selectedBackgroundView = bgView;
        
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        
        UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor colorWithWhite:0.1f alpha:0.2f].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        
        [self.contentView addSubview:myContentView];
        self.radioTypeLabel = [[UILabel alloc] initWithFrame:self.bounds];
#warning 夜间模式改动
        [self.radioTypeLabel NightWithType:UIViewColorTypeNormal];
        [self.radioTypeLabel NightTextType:LabelColorBlack];
        [myContentView addSubview:self.radioTypeLabel];
    }
    return self;
}

// 布局视图

- (void)bindModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [model.dataList lastObject];
    NSArray *nameArray = [dic objectForKey:@"dataList"];
    self.radioTypeLabel.text = [nameArray[indexPath.row] objectForKey:@"name"];
    self.radioTypeLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
