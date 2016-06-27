//
//  RadioPopularItemModel.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface RadioPopularItemModel : BaseModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *comeFrom;
@property (nonatomic, strong) NSString *comeFromId;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *followedNum;
@property (nonatomic, strong) NSString *isOnline;
@property (nonatomic, strong) NSString *listenNum;
@property (nonatomic, strong) NSString *hasCopyright;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray *host;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *utime;

@end
