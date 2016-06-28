//
//  ClassificationCell.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ClassificationCell.h"

@implementation ClassificationCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        
        self.restorationIdentifier = @"identifile_cell";
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        
        CGFloat borderWidth = 0.5f;
    
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        
        UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor colorWithWhite:0.1f alpha:0.2f].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        
        [self.contentView addSubview:myContentView];
         
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    // 创建对象
    self.photoImage = [[UIImageView alloc] init];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:self.photoImage];
    
    [self.contentView addSubview:self.label];
    
    __weak typeof(self)mySelf = self;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mySelf);
        make.right.equalTo(mySelf);
        make.bottom.offset(-10);
    }];
    
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mySelf.label.mas_centerX);
        make.bottom.equalTo(mySelf.label.mas_top).offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    
}
@end
