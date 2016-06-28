//
//  RadioStyleListTableView.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioStyleListTableView.h"
#import "RadioStyleCell.h"


@interface RadioStyleListTableView ()<UITableViewDelegate,UITableViewDataSource>

@end



@implementation RadioStyleListTableView

static NSString * const identifier_styleCell = @"identifier_styleCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[RadioStyleCell class] forCellReuseIdentifier:identifier_styleCell];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RadioStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_styleCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


@end
