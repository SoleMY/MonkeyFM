//
//  ListViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (nonatomic, strong)UIButton *cancleButton;

@end

@implementation ListViewController

- (void)viewDidLoad {
//    self.view.alpha = 0;
    self.view.backgroundColor = [UIColor clearColor];
//    self.view.alpha = 0;
    [super viewDidLoad];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2)];
    self.bgView.alpha = 0.5;
    self.bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bgView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.cancleButton = [[UIButton alloc] init];
    self.cancleButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 30, [UIScreen mainScreen].bounds.size.width, 30);
    self.cancleButton.backgroundColor = [UIColor lightGrayColor];
    [self.cancleButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancleButton];
    
}

- (void)cancleAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
