//
//  TodayModel.h
//  MonkeyFM
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface TodayModel : BaseModel

@property (nonatomic, strong) NSString *rtype;
// 图片上的字
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *rid;
// 图片
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *mp3PlayUrl;
@property (nonatomic, strong) NSString *rvalue;
// 图片下的介绍
@property (nonatomic, strong) NSString *rname;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *name;

@end
