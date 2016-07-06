//
//  MryScrollPageVC.h
//  MryNewsFrameWork
//
//  Created by mryun11 on 16/6/7.
//  Copyright © 2016年 mryun11. All rights reserved.
//

#import "BaseViewController.h"

#import "MryScrollMenu.h"
#import "MryScrollPageCell.h"
#import "MryPageTable.h"
#import "RadioStyleListTableView.h"

typedef void(^sendIndexBlock)(NSInteger);
@interface MryScrollPageVC : BaseViewController

@property (nonatomic,strong) NSMutableArray *tableArray;
@property (nonatomic,strong) NSMutableArray *menuArray;

@property (nonatomic,assign) CGRect menuframe;
@property (nonatomic,assign) CGRect tableframe;

// scrollMenu menu
@property (nonatomic,weak) UITableView *containerTable;
@property (nonatomic,weak) MryScrollMenu *scrollMenu;
@property (nonatomic, copy) sendIndexBlock sendBlock;

- (void)setMenuAndScrollTableView;

@end
