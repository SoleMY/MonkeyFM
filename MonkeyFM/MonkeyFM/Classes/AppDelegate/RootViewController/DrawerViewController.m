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
#import "Masonry.h"
#import "MFM_Tool_COLOR.h"

#define kCellColor [UIColor clearColor]
#define kHeadViewHeight self.rearTableView.frame.size.height / 4
#define kUserPhotoWidth self.rearTableView.frame.size.width / 10

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
    
    // 设置头视图
    [self layoutTableViewHeadView];
    
    //    SWRevealViewController *grandParentRevealController = parentRevealController.revealViewController;

}

- (void)layoutTableViewHeadView
{
    // tableView头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rearTableView.frame.size.width, kHeadViewHeight)];
    headView.backgroundColor = [UIColor clearColor];
    self.rearTableView.tableHeaderView = headView;
    NSLog(@"%f", self.rearTableView.bounds.size.width);
    // 用户头像
    UIImageView *userPhotoImageView = [[UIImageView alloc] init];
    userPhotoImageView.image = [UIImage imageNamed:@"user_photo"];
    userPhotoImageView.backgroundColor = [UIColor grayColor];
    userPhotoImageView.layer.cornerRadius = kUserPhotoWidth / 2;
    userPhotoImageView.layer.masksToBounds = YES;
    [headView addSubview:userPhotoImageView];
    [userPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(71);
        make.left.equalTo(headView).offset(20);
        make.width.mas_equalTo(kUserPhotoWidth);
        make.height.mas_equalTo(kUserPhotoWidth);
    }];
    // 用户名
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.text = @"UserNameLabel";
    [headView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userPhotoImageView.mas_centerY);
        make.left.equalTo(userPhotoImageView.mas_right);
        make.width.mas_equalTo(kUserPhotoWidth * 3);
    }];

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
        RadioViewController *radioViewController = [[RadioViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:radioViewController];
    }
    else if (row == 3)
    {
        
        AnchorViewController *anchorViewController = [[AnchorViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:anchorViewController];
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
