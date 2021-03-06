//
//  RadioTypeCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class RadioModel;

@interface RadioTypeCell : BaseCollectionViewCell

@property (nonatomic, strong) UILabel *radioTypeLabel;

- (void)bindModel:(RadioModel *)model indexPath:(NSIndexPath *)indexPath;

@end
