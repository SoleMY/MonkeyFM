//
//  ClassificationModel.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface ClassificationModel : BaseModel

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *backgroundPic;

@end
