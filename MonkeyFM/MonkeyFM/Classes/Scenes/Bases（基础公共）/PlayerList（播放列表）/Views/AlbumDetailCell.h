//
//  AlbumDetailCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

@interface AlbumDetailCell : BaseCell

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UIImageView *firstImageView;

@property (nonatomic, strong)UIImageView *secondImageView;

@property (nonatomic, strong)UIImageView *thiredImageView;

@property (nonatomic, strong)UILabel *firstLabel;

@property (nonatomic, strong)UILabel *secondLabel;

@property (nonatomic, strong)UILabel *thiredLabel;

- (void)bindWithArray:(NSMutableArray *)array;

@end
