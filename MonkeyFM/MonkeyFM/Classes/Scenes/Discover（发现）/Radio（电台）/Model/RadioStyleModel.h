//
//  RadioStyleModel.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface RadioStyleModel : BaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *currentProgramTitle;
@property (nonatomic, copy) NSString *webPic;
@property (nonatomic, copy) NSString *classifyid;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *onLineNum;
@property (nonatomic, copy) NSString *likedNum;
@property (nonatomic, copy) NSString *type;


@end
