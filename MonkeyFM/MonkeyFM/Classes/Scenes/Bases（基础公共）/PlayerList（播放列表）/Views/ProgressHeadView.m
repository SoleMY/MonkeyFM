//
//  ProgressHeadView.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ProgressHeadView.h"

@implementation ProgressHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"节目", @"评论", @"详情"]];
    self.segment.selectedSegmentIndex = 0;
//    self.segment.tintColor  = [UIColor redColor];
    
    [self addSubview:self.segment];
}

@end
