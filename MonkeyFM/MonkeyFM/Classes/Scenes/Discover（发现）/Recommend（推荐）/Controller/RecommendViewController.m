//
//  RecommendViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RecommendViewController.h"
#import "SWRevealViewController.h"
#define kLeftItemSize(x,y) CGSizeMake(x, y)
@interface RecommendViewController ()
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐";
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
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
