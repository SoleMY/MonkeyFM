//
//  PlayListViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "PlayListViewController.h"
#import "ProgramCell.h"
#import <UIParameter.h>
#import <NinaPagerView.h>

@interface PlayListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation PlayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction)];
    NSArray *titleArray = @[@"节目", @"评论", @"详情"];
    NSArray *VCArray = @[@"ProgramViewController", @"CommentViewController", @"DetaileViewController"];
    NSArray *colorArray = @[[UIColor greenColor], [UIColor grayColor], [UIColor greenColor]];
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithNinaPagerStyle:NinaPagerStyleBottomLine WithTitles:titleArray WithVCs:VCArray WithColorArrays:colorArray];
    [self.view addSubview:ninaPagerView];
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 50;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        ProgramCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 60;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//   ProgressHeadView *view = [[ProgressHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    return view;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}

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
