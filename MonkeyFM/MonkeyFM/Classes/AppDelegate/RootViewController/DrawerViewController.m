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
#import "MineViewController.h"
#import "Masonry.h"
#import "MFM_Tool_COLOR.h"
#import "FileHandleManager.h"
#import "LoginViewController.h"
#import "AVOSCloud/AVOSCloud.h"

#define kCellColor [UIColor clearColor]
#define kHeadViewHeight [UIScreen mainScreen].bounds.size.height / 4.5
#define kUserPhotoWidth [UIScreen mainScreen].bounds.size.width / 6

@interface DrawerViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _presentedRow;
}

// 抽屉的大背景图片
//@property (nonatomic, strong) UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *userPhotoImageView;
@property (nonatomic, strong) UILabel *userNameLabel;


@end

@implementation DrawerViewController
//@synthesize rearTableView = _rearTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kNavigationBarTintColor;
    self.rearTableView.backgroundColor = kDrawerBackgroundColor;
    [self.view addSubview:self.backImageView];
    
    // 设置头视图
    [self layoutTableViewHeadView];
    
    //    SWRevealViewController *grandParentRevealController = parentRevealController.revealViewController;

}

- (void)layoutTableViewHeadView
{
    self.rearTableView.tableHeaderView = nil;
    // tableView头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rearTableView.frame.size.width, kHeadViewHeight)];
    headView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    
    [headView addGestureRecognizer:tap];
    self.rearTableView.tableHeaderView = headView;
    // 用户头像
    UIImageView *userPhotoImageView = [[UIImageView alloc] init];
    
    userPhotoImageView.backgroundColor = [UIColor grayColor];
    userPhotoImageView.layer.cornerRadius = kUserPhotoWidth / 2;
    userPhotoImageView.layer.masksToBounds = YES;
    [headView addSubview:userPhotoImageView];
    self.userPhotoImageView = userPhotoImageView;
    [userPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(71);
        make.left.equalTo(headView).offset(20);
        make.width.mas_equalTo(kUserPhotoWidth);
        make.height.mas_equalTo(kUserPhotoWidth);
    }];
    // 用户名
    UILabel *userNameLabel = [[UILabel alloc] init];
    
    [headView addSubview:userNameLabel];
    self.userNameLabel = userNameLabel;
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userPhotoImageView.mas_centerY);
        make.left.equalTo(userPhotoImageView.mas_right).offset(2);
        make.width.mas_equalTo(kUserPhotoWidth * 3);
    }];
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        AVUser *currentUser = [AVUser currentUser];
        NSData *data = [currentUser objectForKey:@"headImage"];
        self.userPhotoImageView.image = [UIImage imageWithData:data];
        NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
        self.userNameLabel.text = currentUsername;
    } else {
        self.userNameLabel.text = @"用户未登录";
        self.userPhotoImageView.image = [UIImage imageNamed:@"user_photo"];
    }

}

// 头视图手势
- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        AVUser *currentUser = [AVUser currentUser];
        NSData *data = [currentUser objectForKey:@"headImage"];
        self.userPhotoImageView.image = [UIImage imageWithData:data];
        NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
        self.userNameLabel.text = currentUsername;
    }
    [self tableView:self.rearTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = NO;
    [self layoutTableViewHeadView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
        text = @"我的";
    }
//    else if (row == 5)
//    {
//        text = @"清除缓存";
//        NSString *str = [[FileHandleManager shareFileHandleManager] cachesPath];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lfM",[[FileHandleManager shareFileHandleManager] folderSizeAtPath:str]];
//        
//    }
//    else if (row == 6)
//    {
//        text = @"关于我们";
//    }
//    else if (row == 7)
//    {
//        text = @"我的";
//    }
    
    cell.textLabel.text = NSLocalizedString( text, nil );
    cell.backgroundColor = kCellColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        radioViewController.pushBack = ^() {
            _presentedRow++;
        };
    }
    else if (row == 3)
    {
        
        AnchorViewController *anchorViewController = [[AnchorViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:anchorViewController];
    }
//    else if (row == 5)
//    {
//        // 清楚缓存
//        [[FileHandleManager shareFileHandleManager] cleanDownloadImages];
////        [self.rearTableView reloadData];
//    }
    else if (row == 4)
    {
        MineViewController *mineVC = [[MineViewController alloc] init];
        newFrontController = [[BaseNavigationViewController alloc] initWithRootViewController:mineVC];
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
