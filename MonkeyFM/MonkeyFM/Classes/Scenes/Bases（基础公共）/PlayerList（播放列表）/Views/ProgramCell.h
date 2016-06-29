//
//  ProgramCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

@interface ProgramCell : BaseCell

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *listenNumber;
@property (nonatomic, strong)UILabel *likeNumber;
@property (nonatomic, strong)UILabel *commentNumber;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UIButton *moreButton;
@property (nonatomic, strong)UIImageView *listen;
@property (nonatomic, strong)UIImageView *like;
@property (nonatomic, strong)UIImageView *comment;

@end
