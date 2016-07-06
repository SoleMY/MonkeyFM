//
//  RadioDisplayPlayModel.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/2.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface RadioDisplayPlayModel : BaseModel

@property (nonatomic, copy) NSString *backLiveUrl;
@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *broadcastDesc;
@property (nonatomic, copy) NSString *comperes;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *finishTime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *isSubscribe;
@property (nonatomic, copy) NSString *nextProgramId;
@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, copy) NSString *preProgramId;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *title;


@end
