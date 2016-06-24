//
//  RadioModel.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface RadioModel : BaseModel

/// 内容类型
@property (nonatomic, copy) NSString *contentType;
/// 有关系的值
@property (nonatomic, copy) NSString *relatedValue;
/// 图标
@property (nonatomic, copy) NSString *icon;
/// id
@property (nonatomic, copy) NSString *ID;
/// 组成类型
@property (nonatomic, copy) NSString *componentType;
/// 详情（空）
@property (nonatomic, copy) NSString *desc;
/// 图片地址（空）
@property (nonatomic, copy) NSString *pic;
/// 数组中包含字典
@property (nonatomic, copy) NSArray *dataList;
/// 更多类型
@property (nonatomic, copy) NSString *moreType;
///
@property (nonatomic, copy) NSString *count;
/// 内容来源类型
@property (nonatomic, copy) NSString *contentSourceId;
/// 控件名称
@property (nonatomic, copy) NSString *name;
/// 名称
@property (nonatomic, copy) NSString *hasmore;


@end
