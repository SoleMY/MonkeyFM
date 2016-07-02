//
//  PlayerDetailViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "SegmentView.h"
#import "MineTableViewCell.h"
#import "BaseNavigationViewController.h"
#import "SubscriberDataViewController.h"
#define kCell @"cell"
@interface PlayerDetailViewController ()<UITableViewDelegate, UITableViewDataSource, TouchLabelDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *myImageView;

@property (nonatomic, strong) SegmentView *segmentView;

@end

@implementation PlayerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
    
    // 设置tableView
    [self addTableViewMethod];
    // 添加图片上的工种控件
    [self addControls];
    
    // 添加左右navigationbar
    [self addNavBar];
    
    // 添加观察者
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGPoint point = self.tableView.contentOffset;
    if (point.y > 50) {
        UIImageView *smallImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4-140R1102943.jpg"]];
        // 设置圆角
        smallImageView.layer.masksToBounds=YES;
        smallImageView.layer.cornerRadius=40/2.0f; //设置为图片宽度的一半出来为圆形
        //        smallImageView.layer.borderWidth=1.0f; //边框宽度
        //        smallImageView.layer.borderColor=[[UIColor greenColor] CGColor];//边框颜色
        smallImageView.frame = CGRectMake(0, 0, 40, 40);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 200, 30)];
        label.text = @"唐宋元明清丶";
        label.textColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        [view addSubview:label];
        [view addSubview:smallImageView];
        [self.navigationItem setTitleView:view];
        
        
    } else {
        self.navigationItem.titleView = nil;
    }
}

- (void)addNavBar
{
    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
//
//    self.navigationItem.leftBarButtonItems = @[item1, item2];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:nil];
    
}

- (void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTableViewMethod
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    self.myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4-140R1102943.jpg"]];
    self.myImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 220);
    
    // 添加手势
    //图像添加点击事件（手势方法）
    self.myImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    PrivateLetterTap.delegate= self;
    self.myImageView.contentMode = UIViewContentModeScaleToFill;
    [self.myImageView addGestureRecognizer:PrivateLetterTap];
    
    [self setBackImageGlass];
    
    self.tableView.tableHeaderView = self.myImageView;
    // 代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // segment
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
    self.segmentView.titleArray = @[@"收听历史",@"订阅",@"收藏", @"离线"];
    [self.segmentView.scrollLine setBackgroundColor:[UIColor greenColor]];
    self.segmentView.titleSelectedColor = [UIColor brownColor];
    
    self.segmentView.touchDelegate = self;
    
    [self.view addSubview:self.segmentView];
    
    self.tableView.bounces = NO;
    
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:kCell];
}

// 手势事件
- (void)tapAvatarView:(UITapGestureRecognizer *)gesture
{
    SubscriberDataViewController *subscriber = [[SubscriberDataViewController alloc] init];
    [self.navigationController pushViewController:subscriber animated:YES];
    
}
//设置毛玻璃效果
- (void)setBackImageGlass {
    //给背景图添加毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.myImageView.frame];
    //设置toolBar的样式
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [self.myImageView addSubview:toolBar];
}

- (void)addControls
{
    UIImageView *smallImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4-140R1102943.jpg"]];
    [self.myImageView addSubview:smallImageView];
    
    __weak typeof(self)mySelf = self;
    [smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(mySelf.myImageView);
        make.top.equalTo(mySelf.myImageView.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    // 设置圆角
    smallImageView.layer.masksToBounds=YES;
    smallImageView.layer.cornerRadius=100/2.0f; //设置为图片宽度的一半出来为圆形
    smallImageView.layer.borderWidth=1.0f; //边框宽度
    smallImageView.layer.borderColor=[[UIColor greenColor] CGColor];//边框颜色
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.myImageView addSubview:nameLabel];
    [nameLabel sizeToFit];
    nameLabel.font = [UIFont systemFontOfSize:22];
    nameLabel.text = @"唐宋元明清丶";
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smallImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(smallImageView);
    }];
    
    UILabel *numFocusLabel = [[UILabel alloc] init];
    
    numFocusLabel.textColor = [UIColor whiteColor];
    numFocusLabel.text = @"1";
    [numFocusLabel sizeToFit];
    [self.myImageView addSubview:numFocusLabel];
    [numFocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.right.equalTo(nameLabel.mas_left).offset(- 10);
        
    }];
    
    UIButton *FocusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [FocusButton setTitle:@"关注" forState:UIControlStateNormal];
    [FocusButton addTarget:self action:@selector(FocusAction:) forControlEvents:UIControlEventTouchUpInside];
    [FocusButton sizeToFit];
    [self.myImageView addSubview:FocusButton];
    [FocusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(numFocusLabel.mas_bottom).offset(5);
        make.centerX.equalTo(numFocusLabel);
        
    }];
    
    UILabel *numFansLabel = [[UILabel alloc] init];
    
    numFansLabel.textColor = [UIColor whiteColor];
    numFansLabel.text = @"1";
    [numFansLabel sizeToFit];
    [self.myImageView addSubview:numFansLabel];
    [numFansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.left.equalTo(nameLabel.mas_right).offset(- 10);
        
    }];
    
    UIButton *FansButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [FansButton setTitle:@"粉丝" forState:UIControlStateNormal];
    [FansButton addTarget:self action:@selector(FansAction:) forControlEvents:UIControlEventTouchUpInside];
    FansButton.titleLabel.textColor = [UIColor blackColor];
    [FansButton sizeToFit];
    [self.myImageView addSubview:FansButton];
    [FansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(numFansLabel.mas_bottom).offset(5);
        make.centerX.equalTo(numFansLabel);
        
    }];
    
    
}

// 关注的button点击方法
- (void)FocusAction:(UIButton *)sender
{
    NSLog(@"我是关注的点击方法");
}

// 粉丝的点击方法
- (void)FansAction:(UIButton *)sender
{
    NSLog(@"我是粉丝的点击方法");
}

// 分区的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.segmentView;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    
    return cell;
}

// 分区标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *string = @"分区";
//    return string;
//}

// 分区头视图的高度
- (CGFloat)tableView:(UITableView * )tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

// segment代理
- (void)touchLabelWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            break;
        case 1:
            [self.tableView reloadData];
            break;
        case 2:
            if (self.tableView.editing == YES) {
                 [self.tableView setEditing:NO animated:YES];
            } else
            {
                [self.tableView setEditing:YES animated:YES];
            }
            break;
        case 3:
            [self.tableView removeFromSuperview];
            break;
        default:
            break;
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
