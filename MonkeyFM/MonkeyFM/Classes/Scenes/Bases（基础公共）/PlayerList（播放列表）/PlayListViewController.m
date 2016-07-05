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
#import "ProgramViewController.h"
#import "DetaileViewController.h"
#import "PlayerDetailViewController.h"
@interface PlayListViewController ()

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
    ninaPagerView.pushEnabled = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
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
