//
//  RadioStyleListTableView.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^chooseAreaBlock)();

@interface RadioStyleListTableView : UITableView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray *allTableViewInfoArray;

@property (nonatomic, copy) NSString *emptyURL;

@property (nonatomic, copy) chooseAreaBlock chooseBlock;

@property (nonatomic, assign) NSInteger area;

@property (nonatomic, copy) NSString *areaName;

@end
