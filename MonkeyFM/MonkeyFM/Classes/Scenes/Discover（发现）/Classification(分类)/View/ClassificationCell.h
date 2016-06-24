//
//  ClassificationCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationModel.h"

@interface ClassificationCell : UICollectionViewCell

// 声明imageView的子控件
@property (nonatomic, strong)UIImageView *photoImage;
// 声明Label
@property (nonatomic, strong)UILabel *label;

@property (nonatomic, strong)ClassificationModel *model;

@end
