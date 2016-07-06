//
//  PopularItemListViewController.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"



@interface PopularItemListViewController : BaseViewController

// 用于拼接当前页数据接口连接的ID
@property (nonatomic, strong) NSString *relatedValue;

// 接收标题名
@property (nonatomic, copy) NSString *titleName;

@end
