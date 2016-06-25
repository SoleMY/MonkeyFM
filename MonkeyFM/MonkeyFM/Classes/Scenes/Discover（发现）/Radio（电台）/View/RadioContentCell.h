//
//  RadioContentCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class RadioModel;
@interface RadioContentCell : BaseCollectionViewCell

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *bottomLabel;

- (void)bindModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath;

@end
