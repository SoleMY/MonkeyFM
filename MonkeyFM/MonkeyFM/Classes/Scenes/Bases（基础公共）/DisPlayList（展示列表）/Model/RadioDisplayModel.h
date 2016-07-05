//
//  RadioDisplayModel.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/2.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface RadioDisplayModel : BaseModel

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *classifyId;
@property (nonatomic, copy) NSString *classifyName;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *isSubscribe;
@property (nonatomic, copy) NSString *likedNum;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *onLineNum;
@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *webPic;


@end
