//
//  DetaileViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetaileViewController.h"
#import "DetaileCell.h"
#import "KeywordsCell.h"
#import "IntroductionCell.h"
#import "AlbumDetailCell.h"

@interface DetaileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, assign)NSInteger heightForCellButton;

@property (nonatomic, assign)NSInteger heightForCellText;

@end

@implementation DetaileViewController

- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[DetaileCell class] forCellReuseIdentifier:@"detaileCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[KeywordsCell class] forCellReuseIdentifier:@"keyWordCell"];
    [self.tableView registerClass:[IntroductionCell class] forCellReuseIdentifier:@"introductionCell"];
    [self.tableView registerClass:[AlbumDetailCell class] forCellReuseIdentifier:@"albumCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DetaileCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detaileCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 1) {
        KeywordsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"keyWordCell" forIndexPath:indexPath];
        self.heightForCellButton = cell.numberOfButton;
        return cell;
    }else if (indexPath.row == 2) {
        IntroductionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"introductionCell" forIndexPath:indexPath];
       self.heightForCellText = [SmallTools textHeightWithText:cell.introductionText.text font:[UIFont systemFontOfSize:13]];
        return cell;
    }else if (indexPath.row == 3) {
        AlbumDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"albumCell" forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == 1){
        return self.heightForCellButton * 40;
    }else if (indexPath.row == 2) {
        return self.heightForCellText + 50;
    }else if (indexPath.row == 3) {
        return 190;
    }
    else {
    return 100;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
