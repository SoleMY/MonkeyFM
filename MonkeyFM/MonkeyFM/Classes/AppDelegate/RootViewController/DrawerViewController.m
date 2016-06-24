//
//  DrawerViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DrawerViewController.h"
#import "SWRevealViewController.h"
#import "RecommendViewController.h"
#import "BaseNavigationViewController.h"
#import "ClassificationController.h"
#import "AnchorViewController.h"
#import "RadioViewController.h"

#define kCellColor [UIColor clearColor]

@interface DrawerViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _presentedRow;
}

// 抽屉的大背景图片
@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation DrawerViewController
//@synthesize rearTableView = _rearTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.backImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.backImageView];

    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    headView.backgroundColor = [UIColor blueColor];
//    UIImageView *userPhotoImageView = [[UIImageView alloc] initWithFrame:<#(CGRect)#>]
    self.rearTableView.tableHeaderView = headView;
//    SWRevealViewController *grandParentRevealController = parentRevealController.revealViewController;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *text = nil;
    if (row == 0)
    {
        text = @"推荐";
    }
    else if (row == 1)
    {
        text = @"分类";
    }
    else if (row == 2)
    {
        text = @"电台";
    }
    else if (row == 3)
    {
        text = @"主播";
    }
    else if (row == 4)
    {
        text = @"夜间模式";
    }
    else if (row == 5)
    {
        text = @"清除缓存";
    }
    else if (row == 6)
    {
        text = @"关于我们";
    }
    
    cell.textLabel.text = NSLocalizedString( text, nil );
    cell.backgroundColor = kCellColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if ( row == _presentedRow )
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
//    else if (row == 2)
//    {
//        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
//        return;
//    }
//    else if (row == 3)
//    {
//        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
//        return;
//    }
    
    // otherwise we'll create a new frontViewController and push it with animation
    
    UIViewController *newFrontController = nil;
    
    if (row == 0)
    {
        RecommendViewController *recommendViewController = [[RecommendViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:recommendViewController];
    }
    
    else if (row == 1)
    {
        ClassificationController *classificationController = [[ClassificationController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:classificationController];
    }
    else if (row == 2)
    {
        AnchorViewController *anchorViewController = [[AnchorViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:anchorViewController];
    }
    else if (row == 3)
    {
        RadioViewController *radioViewController = [[RadioViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:radioViewController];
    }
    else {
        return;
    }
//    else if ( row == 4 )
//    {
//        FrontViewController *frontViewController = [[FrontViewController alloc] init];
//        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
//        
//        RearViewController *rearViewController = [[RearViewController alloc] init];
//        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
//        
//        SWRevealViewController *childRevealController = [[SWRevealViewController alloc]
//                                                         initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
//        
//        childRevealController.rearViewRevealDisplacement = 0.0f;
//        [childRevealController setFrontViewPosition:FrontViewPositionRight animated:NO];
//        
//        newFrontController = childRevealController;
//    }
    
    [revealController pushFrontViewController:newFrontController animated:YES];
    
    _presentedRow = row;  // <- store the presented row
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
