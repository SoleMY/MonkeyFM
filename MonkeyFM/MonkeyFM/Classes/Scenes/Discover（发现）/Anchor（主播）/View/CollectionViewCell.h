//
//  CollectionViewCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheHostShow.h"
@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)TheHostShow *HostShow;


///头像
@property (nonatomic, strong)UIImageView *headPortrait;

///姓名
@property (nonatomic, strong)UILabel *nameLabel;

///简介
@property (nonatomic, strong)UILabel *introduction;

@end
