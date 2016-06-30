//
//  MainTableView.h
//  MryNewsFrameWork
//
//  Created by mryun11 on 16/6/7.
//  Copyright © 2016年 mryun11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "NewsAllModel.h"
#import "DetailSegment.h"
@interface MryPageTable : UITableView

@property (nonatomic,copy) NSString *title;

@property (nonatomic, strong) NewsAllModel *model;

@property (nonatomic, strong) DetailSegment *segmentModel;



@property (nonatomic, strong) NSString *string;

@end
