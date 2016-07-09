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
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerManager.h"

#define kCell @"cell"

typedef NS_ENUM(NSUInteger, isPlay) {
    Play,
    Pause,
};

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, TouchLabelDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    isPlay _isplay;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *myImageView;

@property (nonatomic, strong) SegmentView *segmentView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *smallImageView;

@property (nonatomic, strong) UIImagePickerController *imagePicker; //图片选择器

@property (nonatomic, strong)NSMutableArray *allCollectionArray;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)NSMutableArray *allSubscribeArray;

@property (nonatomic, strong)NSMutableArray *allDownLoadArray;

@property (nonatomic, strong)AVPlayer *player;

@end

@implementation MineViewController

- (NSMutableArray *)allDownLoadArray {
    if (!_allDownLoadArray) {
        _allDownLoadArray = [NSMutableArray array];
    }
    return _allDownLoadArray;
}

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
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    
    // 设置tableView
    [self addTableViewMethod];
    
    
    // 添加左右navigationbar
//    [self addNavBar];
    
    // 添加观察者
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"subCell"];
    _isplay = Pause;
    self.index = 0;
    
    self.title = @"个人中心";
    
    [self.tableView NightWithType:UIViewColorTypeNormal];
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
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *array =   [manager contentsOfDirectoryAtPath:caches error:nil];
    self.allDownLoadArray = nil;
    for (NSString *str in array) {
        if ( [str rangeOfString:@".mp3"].location != NSNotFound){
            [self.allDownLoadArray addObject:str];
        }
    }
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_player pause];
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

//- (void)addNavBar
//{
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(cancleButton:)];
//    
//}


// 右按钮注销
- (void)cancleButton:(UIBarButtonItem *)sender
{
    [AVUser logOut];
    self.nameLabel.text = @"您还未登录";
    self.smallImageView.image = [UIImage imageNamed:@"user_photo"];
    self.myImageView.image = [UIImage imageNamed:@""];
    self.myImageView.backgroundColor = kNavigationBarTintColor;
    self.allSubscribeArray = nil;
    self.allCollectionArray = nil;
    [self.tableView reloadData];
}
- (void)addTableViewMethod
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    
    [self setTableViewHeaderView];
    // 代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // segment
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];

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
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    // 注销button
    UIImageView *outImageView = [[UIImageView alloc] init];
    outImageView.image = [UIImage imageNamed:@"sign-out"];
    [self.myImageView addSubview:outImageView];
    outImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *outTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleButton:)];
    // 设置轻拍次数
    outTapGR.numberOfTapsRequired = 1;
    
    outTapGR.delegate = self;
    
    // 添加手势
    [outImageView addGestureRecognizer:outTapGR];
    
    [outImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(mySelf.myImageView.mas_top).offset(20);
        make.right.equalTo(mySelf.myImageView.mas_right).offset(-20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
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
    
    if (self.index == 0) {
        return self.allSubscribeArray.count;
    }else if (self.index == 1) {
        return self.allCollectionArray.count;
    }else {
        return self.allDownLoadArray.count;
    }
    
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 1) {
    
    MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
#warning 夜间模式改动
    [cell NightWithType:UIViewColorTypeNormal];
    //    AVObject *object = self.allCollectionArray[indexPath.row];
    [cell cellBindWithObject:self.allCollectionArray[indexPath.row]];
    NSLog(@"%ld", _allCollectionArray.count);
        return cell;
    } else if(self.index == 0){
    MineTableViewCell *subCell = [self.tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
        subCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [subCell cellBindWithObject:self.allSubscribeArray[indexPath.row]];
//    cell.nameLabel.text = [object objectForKey:@"name"];
    return subCell;
    } else if (self.index == 2){
        MineTableViewCell *subCell = [self.tableView dequeueReusableCellWithIdentifier:@"downLoadCell" forIndexPath:indexPath];
        subCell.selectionStyle = UITableViewCellSelectionStyleNone;
        subCell.nameLabel.text = self.allDownLoadArray[indexPath.row];
        subCell.descLabel.text = @"";
        subCell.utimeLabel.text = @"";
        subCell.pic.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0  blue:arc4random() % 256 / 255.0  alpha:1];
#warning 夜间模式改动
        [subCell NightWithType:UIViewColorTypeNormal];
        subCell.pic.layer.cornerRadius = 20;
        subCell.pic.layer.masksToBounds = YES;
        return subCell;
    }
    
    MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
            [self.tableView reloadData];
            [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"downLoadCell"];
            break;
        default:
            break;
    }
}

- (void)showCollection {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser) {
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
}

- (void)showSubscribe {
    AVUser *currentUsre = [AVUser currentUser];
    if (currentUsre) {
    AVQuery *query = [AVQuery queryWithClassName:@"Subscribe"];
    [query whereKey:@"userName" equalTo:currentUsre.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _allSubscribeArray = objects.mutableCopy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.index == 0) {
        AVObject *object = self.allSubscribeArray[indexPath.row];
        [[SingleList shareSingleList].dict setObject:[object objectForKey:@"ID"] forKey:@"ID"];
        [self.navigationController pushViewController:[[PlayListViewController alloc] init] animated:YES];
    } else if (self.index == 1) {
        AVObject *object = self.allCollectionArray[indexPath.row];
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
    } else if (self.index ==2) {
        if (_isplay == Pause) {
        
            NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *str = [NSString stringWithFormat:@"%@/%@", caches,self.allDownLoadArray[indexPath.row]];
            NSURL *fileURL = [NSURL fileURLWithPath:str];
            _isplay = Play;
            
            
            if ([AVPlayerManager shareAVPlayerManager].status == isPlaying) {
                [[AVPlayerManager shareAVPlayerManager] stop];
            }
            _player = [[AVPlayer alloc] initWithURL:fileURL];
//            [AVPlayerManager shareAVPlayerManager]
            [_player play];
        } else {
            [_player pause];
            _isplay = Pause;
        }
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.index == 0) {
            AVObject *object = self.allSubscribeArray[indexPath.row];
            [object deleteInBackground];
            [self.allSubscribeArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else if (self.index == 1) {
            AVObject *object = self.allCollectionArray[indexPath.row];
            [object deleteInBackground];
            [self.allCollectionArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else if (self.index == 2) {
            NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *str = [NSString stringWithFormat:@"%@/%@", caches,self.allDownLoadArray[indexPath.row]];
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:str error:nil];
            [self.allDownLoadArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
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
