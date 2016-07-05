//
//  NewsAllModel.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface NewsAllModel : BaseModel

/// 标题
@property (nonatomic, strong) NSString *name;

/// 图片
@property (nonatomic, strong) NSString *pic;

/// 内容
@property (nonatomic, strong) NSString *desc;

/// 评论数
@property (nonatomic, strong) NSString *hot;

/// 时间
@property (nonatomic, strong) NSString *utime;

/// id
@property (nonatomic, assign) NSInteger Id;

@end
