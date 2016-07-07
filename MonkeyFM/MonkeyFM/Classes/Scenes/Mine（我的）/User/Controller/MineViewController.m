//
//  MineViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "MineViewController.h"
#import "SegmentView.h"
#import "MineTableViewCell.h"
#import "BaseNavigationViewController.h"
#import "LoginViewController.h"
#import "AVOSCloud/AVOSCloud.h"
#import "PlayerDetailViewController.h"
#import "SingleList.h"
#import "PlayListViewController.h"
#import "NetWorking.h"
#import "SettingViewController.h"

#define kCell @"cell"
@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, TouchLabelDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *myImageView;

@property (nonatomic, strong) SegmentView *segmentView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *smallImageView;

@property (nonatomic, strong) UIImagePickerController *imagePicker; //图片选择器

@property (nonatomic, strong)NSMutableArray *allCollectionArray;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)NSMutableArray *allSubscribeArray;

@end

@implementation MineViewController

- (NSMutableArray *)allSubscribeArray {
    if (!_allSubscribeArray) {
        _allSubscribeArray = [NSMutableArray array];
    }
    return _allSubscribeArray;
}

- (NSMutableArray *)allCollectionArray {
    if (!_allCollectionArray) {
        _allCollectionArray = [NSMutableArray array];
    }
    return _allCollectionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    ((BaseNavigationViewController *)weakSelf.navigationController).customSearchBar.hidden = YES;
    
    // 设置tableView
    [self addTableViewMethod];
    
    
    // 添加左右navigationbar
    [self addNavBar];
    
    // 添加观察者
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"subCell"];
    
    self.index = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self showSubscribe];
    AVUser *currentUser = [AVUser currentUser];
    
    NSData *data = [currentUser objectForKey:@"headImage"];
    self.myImageView.image = [UIImage imageWithData:data];
    
    if (currentUser != nil) {
        NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
        self.nameLabel.text = currentUsername;
        self.smallImageView.image = self.myImageView.image;
        [self.tableView reloadData];
    } else {
        self.smallImageView.image = [UIImage imageNamed:@"user_photo"];
        self.myImageView.backgroundColor = kNavigationBarTintColor;
        self.nameLabel.text = @"您还未登录";
        
        [self.tableView reloadData];
    }
    [self.tableView reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGPoint point = self.tableView.contentOffset;
    if (point.y > 50) {
        UIImageView *smallImageView = [[UIImageView alloc] initWithImage:_myImageView.image];
        // 设置圆角
        smallImageView.layer.masksToBounds=YES;
        smallImageView.layer.cornerRadius=40/2.0f; //设置为图片宽度的一半出来为圆形
//        smallImageView.layer.borderWidth=1.0f; //边框宽度
//        smallImageView.layer.borderColor=[[UIColor orangeColor] CGColor];//边框颜色
        smallImageView.frame = CGRectMake(0, 0, 40, 40);

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        [view addSubview:nameLabel];
        
        [view addSubview:smallImageView];
        [self.navigationItem setTitleView:view];
        
        
    } else {
        self.navigationItem.titleView = nil;
    }
}

- (void)addNavBar
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(cancleButton:)];
    
}


// 右按钮注销
- (void)cancleButton:(UIBarButtonItem *)sender
{
    [AVUser logOut];
    self.nameLabel.text = @"您还未登录";
    self.smallImageView.image = [UIImage imageNamed:@"user_photo"];
    self.myImageView.image = [UIImage imageNamed:@""];
    self.myImageView.backgroundColor = kNavigationBarTintColor;
    [self.tableView reloadData];
}
- (void)addTableViewMethod
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    [self setTableViewHeaderView];
    // 代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // segment
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
#warning 夜间模式改动
    [self.segmentView NightWithType:UIViewColorTypeNormal];

    self.segmentView.titleArray = @[@"订阅",@"收藏", @"离线"];
    [self.segmentView.scrollLine setBackgroundColor:[UIColor greenColor]];
    self.segmentView.titleSelectedColor = [UIColor brownColor];
    
    self.segmentView.touchDelegate = self;
    
    [self.view addSubview:self.segmentView];
    
//    self.tableView.bounces = NO;
    
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:kCell];
}

- (void)setTableViewHeaderView
{
    self.tableView.tableHeaderView = nil;
    self.myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4-140R1102943"]];
    self.myImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 220);
    
    self.myImageView.userInteractionEnabled = YES;
    
    [self setBackImageGlass];
    
    self.tableView.tableHeaderView = self.myImageView;
    
    // 添加图片上的各种控件
    [self addControls];
    
}

// 手势
- (void)tapAvatarView:(UIGestureRecognizer *)sender
{
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 跳转到首页
        
        NSLog(@"当前用户正在登录中");
        // 调用系统相册、相机
        // 添加alertSheet
        __weak typeof(self)weakSelf = self;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _imagePicker.allowsEditing = YES;
            [weakSelf presentViewController:_imagePicker animated:YES completion:nil];
        }];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _imagePicker.allowsEditing = YES;
            [weakSelf presentViewController:_imagePicker animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:photoAction];
        [alert addAction:cameraAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        LoginViewController *login = [[LoginViewController alloc] init];
//        login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController pushViewController:login animated:YES];
    }
    
}
//设置毛玻璃效果
- (void)setBackImageGlass {
    //给背景图添加毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.myImageView.frame];
    //设置toolBar的样式
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    toolBar.alpha = 0.7;
    
    [UIView animateWithDuration:1 animations:^{
        [self.myImageView addSubview:toolBar];
    }];
    
}

- (void)addControls
{
     __weak typeof(self)mySelf = self;
    UIImageView *settingImageView = [[UIImageView alloc] init];
    settingImageView.image = [UIImage imageNamed:@"settings"];
    [self.myImageView addSubview:settingImageView];
    settingImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSettingImageView:)];
    // 设置轻拍次数
    aTapGR.numberOfTapsRequired = 1;
    
    aTapGR.delegate = self;
    
    // 添加手势
    [settingImageView addGestureRecognizer:aTapGR];

    [settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mySelf.myImageView.mas_top).offset(20);
        make.left.equalTo(mySelf.myImageView.mas_left).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    self.smallImageView = [[UIImageView alloc] initWithImage:self.myImageView.image];
    [self.myImageView addSubview:_smallImageView];
    
   
    [_smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(mySelf.myImageView);
        make.top.equalTo(mySelf.myImageView.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    // 设置圆角
    _smallImageView.layer.masksToBounds=YES;
    _smallImageView.layer.cornerRadius=100/2.0f; //设置为图片宽度的一半出来为圆形
    _smallImageView.layer.borderWidth=1.0f; //边框宽度
    _smallImageView.layer.borderColor=[[UIColor greenColor] CGColor];//边框颜色
    
    // 添加手势
    _smallImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    PrivateLetterTap.delegate= self;
    _smallImageView.contentMode = UIViewContentModeScaleToFill;
    [_smallImageView addGestureRecognizer:PrivateLetterTap];
    
    
    self.nameLabel = [[UILabel alloc] init];
    //    NSString *currentEmail = [AVUser currentUser].email
    
    [self.myImageView addSubview:self.nameLabel];
    [self.nameLabel sizeToFit];
    self.nameLabel.font = [UIFont systemFontOfSize:22];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_smallImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(_smallImageView);
    }];
    
    UILabel *numFocusLabel = [[UILabel alloc] init];
    
    numFocusLabel.textColor = [UIColor whiteColor];
    numFocusLabel.text = @"0";
    [numFocusLabel sizeToFit];
    [self.myImageView addSubview:numFocusLabel];
    [numFocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.right.equalTo(_nameLabel.mas_left).offset(- 10);
        
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
    numFansLabel.text = @"0";
    [numFansLabel sizeToFit];
    [self.myImageView addSubview:numFansLabel];
    [numFansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.left.equalTo(_nameLabel.mas_right).offset(10);
        
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 赋值头像
    _myImageView.image = image;
    
    // ==== //
    // AVUser 存储
    NSData *data = UIImageJPEGRepresentation(image,1.0);
    [[AVUser currentUser] setObject:data forKeyedSubscript:@"headImage"];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"##########%@", error);
    }];
    
    // ==== //
    
    // 如果是相机
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    [self.tableView reloadData];
    // dismiss当前的选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}
#warning 这个需要实现什么
- (void)saveImage {
    NSLog(@"存储图片...");
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



// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.allCollectionArray.count);
    
    if (self.index == 0) {
        return self.allSubscribeArray.count;
    }else if (self.index == 1) {
        return self.allCollectionArray.count;
    }else {
        return 0;
    }
    
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 1) {
    
    MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    AVObject *object = self.allCollectionArray[indexPath.row];
    [cell cellBindWithObject:self.allCollectionArray[indexPath.row]];
    NSLog(@"%ld", _allCollectionArray.count);
        return cell;
    } else if(self.index == 0){
    MineTableViewCell *subCell = [self.tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
        [subCell cellBindWithObject:self.allSubscribeArray[indexPath.row]];
//    cell.nameLabel.text = [object objectForKey:@"name"];
    return subCell;
    } else {
        MineTableViewCell *subCell = [self.tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
//        [subCell cellBindWithObject:self.allSubscribeArray[indexPath.row]];
        //    cell.nameLabel.text = [object objectForKey:@"name"];
        return subCell;
    }
    MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
#warning 夜间模式改动
    [cell NightWithType:UIViewColorTypeNormal];
    return cell;
    
}




// 分区头视图的高度
- (CGFloat)tableView:(UITableView * )tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

// segment代理
- (void)touchLabelWithIndex:(NSInteger)index
{
    self.index = index;
    switch (index) {
        case 0:
            [self showSubscribe];
            [self.tableView reloadData];
            [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"subCell"];
            break;
        case 1:
            [self showCollection];
            [self.tableView reloadData];
            [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"cell"];
            break;
        case 2:
             [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"downLoadCell"];
            if (self.tableView.editing == YES) {
                [self.tableView setEditing:NO animated:YES];
            } else {
                [self.tableView setEditing:YES animated:YES];
            }
            break;
        default:
            break;
    }
}

- (void)showCollection {
    AVUser *currentUser = [AVUser currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"Album"];
    [query whereKey:@"userName" equalTo:currentUser.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _allCollectionArray = objects.mutableCopy;
        NSLog(@"%@", objects);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)showSubscribe {
    AVUser *currentUsre = [AVUser currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"Subscribe"];
    [query whereKey:@"userName" equalTo:currentUsre.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _allSubscribeArray = objects.mutableCopy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.index == 0) {
        AVObject *object = self.allSubscribeArray[indexPath.row];
        [[SingleList shareSingleList].dict setObject:[object objectForKey:@"ID"] forKey:@"ID"];
        [self.navigationController pushViewController:[[PlayListViewController alloc] init] animated:YES];
    } else if (self.index == 1) {
        AVObject *object = self.allCollectionArray[indexPath.row];
//       NSArray *array = [object objectForKey:@"array"];
        NSInteger row = [[object objectForKey:@"row"] integerValue];
        NSString *str= [object objectForKey:@"ID"];
        NSInteger pageNum = row / 10 + 1;
        NSString *URLString = [NSString stringWithFormat:@"%@%@%@%ld%@", PLAY_LIST_PROGRAM_BASEURL, str, PLAY_LIST_PROGRAM_APPEND,pageNum, PLAY_LIST_PROGRAM_APPENDTWO];
        NSLog(@"%@", URLString);
        NetWorking *netWorking = [[NetWorking alloc] init];
        [netWorking requestWithURL:URLString Bolck:^(id array) {
            NSDictionary *resultDic = array[@"result"];
            
            NSArray *dataList = resultDic[@"dataList"];
            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSDictionary *dict in dataList) {
                PlayList *playList =  [[PlayList alloc] init];
                [playList setValuesForKeysWithDictionary:dict];
//                [self.allDataArray addObject:playList];
                [dataArray addObject:playList];
            }
            PlayerDetailViewController *playerVC = [[PlayerDetailViewController alloc] init];
            playerVC.allDataArray = dataArray;
            playerVC.row = row;
            [self.navigationController pushViewController:playerVC animated:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView  reloadData];
            });
        }];
        
        
        
    }
}


- (void)tapSettingImageView:(UIGestureRecognizer *)sender
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
