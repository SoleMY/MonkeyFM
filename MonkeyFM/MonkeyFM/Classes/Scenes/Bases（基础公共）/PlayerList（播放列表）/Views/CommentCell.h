//
//  CommentCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

@interface CommentCell : BaseCell

@property (nonatomic, strong)UIImageView *headImage;

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *dateLabel;

@property (nonatomic, strong)UILabel *commentLabel;

@property (nonatomic, strong)UILabel *zanNumber;

@property (nonatomic, strong)UIButton *zanButton;

@end
