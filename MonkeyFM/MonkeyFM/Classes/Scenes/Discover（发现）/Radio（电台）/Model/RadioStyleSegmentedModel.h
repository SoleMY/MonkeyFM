//
//  RadioStyleSegmentedModel.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface RadioStyleSegmentedModel : BaseModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSArray *dataList;

@end