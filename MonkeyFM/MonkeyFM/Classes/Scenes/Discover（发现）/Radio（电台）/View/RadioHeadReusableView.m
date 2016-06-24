//
//  RadioHeadReusableView.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioHeadReusableView.h"

@implementation RadioHeadReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
//    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    self.headImageView.backgroundColor = [UIColor blueColor];
//    [self addSubview:self.headImageView];
}

@end
