//
//  AnchorViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AnchorViewController.h"
#import "TheHostShow.h"
@interface AnchorViewController ()

@end

@implementation AnchorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view from its nib.
    TheHostShow *host = [[TheHostShow alloc] init];
    host.frame =CGRectMake(0, 200, self.view.frame.size.width , 200);
    [self.view addSubview:host];
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
