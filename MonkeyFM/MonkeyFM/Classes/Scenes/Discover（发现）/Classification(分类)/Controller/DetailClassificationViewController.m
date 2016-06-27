//
//  DetailClassificationViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetailClassificationViewController.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface DetailClassificationViewController ()

@end

@implementation DetailClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonClick)];
    
#pragma mark - demo
    //设置数据源
    self.menuArray = [NSMutableArray arrayWithArray:@[@"推荐热点热点",@"科技",@"体育",@"视频",@"要闻",@"时政",@"美女",@"搞笑",@"娱乐", @"推荐热点热点"]];
    self.tableArray = [NSMutableArray arrayWithCapacity:self.menuArray.count];
    for (NSString *title in self.menuArray) {
        MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.title = title;
        [self.tableArray addObject:table];
    }
    
    //设置控件位置
    self.menuframe = CGRectMake(0, 64, ScreenW, 40);
    self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), ScreenW, ScreenH - CGRectGetMaxY(self.menuframe));
    
    //调用父类方法加载控件
    [super viewDidLoad]; //最后执行

}

- (void)backBarButtonClick {
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
