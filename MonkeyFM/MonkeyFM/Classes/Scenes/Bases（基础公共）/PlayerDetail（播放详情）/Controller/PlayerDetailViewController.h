//
//  PlayerDetailViewController.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayList.h"
@interface PlayerDetailViewController : BaseViewController

@property (nonatomic, strong)PlayList *playList;

@property (nonatomic, strong)NSMutableArray *allDataArray;

@property (nonatomic, assign)NSInteger row;

@property (nonatomic, strong)NSMutableArray *dataArray;

@end
