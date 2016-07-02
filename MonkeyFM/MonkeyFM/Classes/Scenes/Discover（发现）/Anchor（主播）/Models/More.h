//
//  More.h
//  MonkeyFM
//
//  Created by 郑淮予  on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

@interface More : BaseCell

@property (nonatomic, strong)NSString *nickName;
@property (nonatomic, strong)NSString *avatar;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, assign)NSInteger fansCount;
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *audioName;
@property (nonatomic, strong)NSString *audioPic;
@property (nonatomic, strong)NSString *albumName;
@property (nonatomic, strong)NSString *NewTitle;
@property (nonatomic, assign)NSInteger Id;
//主播详情界面
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *pic
;
@end
