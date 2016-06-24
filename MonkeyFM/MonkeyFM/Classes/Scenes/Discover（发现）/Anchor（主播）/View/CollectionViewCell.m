//
//  CollectionViewCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.HostShow = [[TheHostShow alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.HostShow];
}


@end
