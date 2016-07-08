//
//  PlayerDetailViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "SingleList.h"
#import "NetWorking.h"
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerManager.h"
#import "ListViewController.h"
#import "UMSocial.h"
#import "AVOSCloud/AVOSCloud.h"
#import "LoginViewController.h"

#define KAVPlayerManager [AVPlayerManager shareAVPlayerManager]

typedef NS_ENUM(NSUInteger, LoopMode) {
    SingleMode,//单曲
    RandomMode,//随机
    OrderMode,//顺序
};

typedef NS_ENUM(NSUInteger, isCollect) {
    Collected,//收藏
    UnCollect,//未收藏
};

typedef NS_ENUM(NSUInteger, isSubscribe) {
    Subsricbe,
    UnSubscribe,
};

@interface PlayerDetailViewController ()<AVPlayerManagerDelegate, UMSocialUIDelegate, NSURLSessionDownloadDelegate>
{
    LoopMode _loopMode; //用来记录当前的播放模式
    
    isCollect _iscollect;
    
    isSubscribe _issubscribe;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowLabel;
@property (weak, nonatomic) IBOutlet UILabel *allTime;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
//@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet UIButton *modeButton;
//@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, strong)NSString *mp3URL;
@property (nonatomic, strong)AVPlayer *avPlayer;
@property (nonatomic, assign)AVPlayerManagerStatus statu;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (nonatomic, strong)NSURLSession *session;
@property (nonatomic, strong)NSURLSessionDownloadTask *task;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;


@end

@implementation PlayerDetailViewController

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray *)allDataArray {
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    PlayList *plist=  self.allDataArray[self.row];
    AVQuery *query = [AVQuery queryWithClassName:@"Album"];
    [query getObjectInBackgroundWithId:[[SingleList shareSingleList].objectIDdic objectForKey:plist.audioName] block:^(AVObject *object, NSError *error) {
        
        if ([object objectForKey:@"name"]) {
            _iscollect = Collected;
            [self.collectButton setImage:[UIImage imageNamed:@"chat_support_blue@2x"] forState:UIControlStateNormal];
        }else {
            _iscollect = UnCollect;
            [self.collectButton setImage:[UIImage imageNamed:@"chat_support_green@2x"] forState:UIControlStateNormal];
        }
    }];
    AVQuery *subscribeQuery = [AVQuery queryWithClassName:@"Subscribe"];
    [subscribeQuery getObjectInBackgroundWithId:[[SingleList shareSingleList].subscribeIDdic objectForKey:plist.audioName] block:^(AVObject *object, NSError *error) {
        if ([object objectForKey:@"name"]) {
            _issubscribe = Subsricbe;
            [self.subscribeButton setImage:[UIImage imageNamed:@"btn_audioplayer_subscribe_on"] forState:UIControlStateNormal];
        } else {
            _issubscribe = UnSubscribe;
            [self.subscribeButton setImage:[UIImage imageNamed:@"btn_audioplayer_subscribe"] forState:UIControlStateNormal];
        }
    }];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *array = [manager contentsOfDirectoryAtPath:caches error:nil];
    for (NSString *str in array) {
        if ([str rangeOfString:plist.audioName].location !=NSNotFound) {
            [self.downLoadButton setImage:[UIImage imageNamed:@"btn_offline_delete_select"] forState:UIControlStateNormal];
        }
    }
    
}

- (void)viewDidLoad {
//    AVAudioPlayer
    [super viewDidLoad];
    self.firstImage.alpha = 0;
    self.firstImage.backgroundColor = [UIColor lightGrayColor];
    self.secondImage.alpha = 0;
    self.secondImage.backgroundColor = [UIColor lightGrayColor];
    self.thirdImage.alpha = 0;
    self.fourthImage.backgroundColor = [UIColor lightGrayColor];
    self.fourthImage.alpha = 0;
    self.thirdImage.backgroundColor = [UIColor lightGrayColor];
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(10, 10);
    self.contentView.layer.shadowOpacity = 0.7;//不透明度
    self.contentView.layer.shadowRadius = 10.0;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self initLayout];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBarHidden = YES;
    self.headImage.alpha = 1;
    [self.backButton addTarget: self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [[AVPlayerManager shareAVPlayerManager] playWithUrl:self.mp3URL];
    [self.playButton setImage:[UIImage imageNamed:@"btn_broadcastplayer_pause"] forState:UIControlStateNormal];
    self.progressSlider.value= 0;
    KAVPlayerManager.delegate = self;
    _loopMode = OrderMode;
}
- (IBAction)LoopMode:(id)sender {
    if (_loopMode == SingleMode) {
        [self.modeButton setImage:[UIImage imageNamed:@"btn_audioplayer_playmode_random"] forState:UIControlStateNormal];
        _loopMode = RandomMode;
    } else if (_loopMode == RandomMode) {
        [self.modeButton setImage:[UIImage imageNamed:@"btn_audioplayer_playmode_loop"] forState:UIControlStateNormal];
        _loopMode = OrderMode;
    } else {
        [self.modeButton setImage:[UIImage imageNamed:@"btn_audioplayer_playmode_single"] forState:UIControlStateNormal];
        _loopMode = SingleMode;
    }
    
}
- (IBAction)listAction:(id)sender {
    [self presentViewController:[[ListViewController alloc] init] animated:YES completion:nil];
}

- (IBAction)playAction:(id)sender {
    if (KAVPlayerManager.status == isPlaying) {
        [self.playButton setImage:[UIImage imageNamed:@"btn_broadcastplayer_play"] forState:UIControlStateNormal];
        [KAVPlayerManager pause];
    } else {
        [self.playButton setImage:[UIImage imageNamed:@"btn_broadcastplayer_pause"] forState:UIControlStateNormal];
//        [KAVPlayerManager playWithUrl:self.mp3URL];
        [KAVPlayerManager play];
    }
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)initLayout {
    PlayList *playlist = self.allDataArray[self.row];
//    NSLog(@"%@", playlist.albumPic);
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:playlist.albumPic]];
    self.bgImageView.image = [self.bgImageView setImageToBlur:self.bgImageView.image blurRadius:50];
    self.titleLabel.text = playlist.audioName;
    [self.albumImage sd_setImageWithURL:[NSURL URLWithString:playlist.albumPic]];
    self.headImage.image  = self.albumImage.image;
    self.mp3URL = playlist.mp3PlayUrl;
    self.progressSlider.maximumValue = playlist.mp3Duration / 1000;
    self.allTime.text = [NSString stringWithFormat:@"%.2f", self.progressSlider.maximumValue / 60];
    self.nowLabel.text = [NSString stringWithFormat:@"%.2f", self.progressSlider.value];
}



- (void)pause {
    [self.playButton setImage:[UIImage imageNamed:@"btn_broadcastplayer_play"] forState:UIControlStateNormal];
    [KAVPlayerManager pause];
    KAVPlayerManager.status = isPaused;
}


- (IBAction)nextButtonClick:(id)sender {
    NSInteger pageNum = self.allDataArray.count / 10;
    if (self.row < self.allDataArray.count -1) {
        if (_loopMode == RandomMode) {
            self.row = arc4random() % self.allDataArray.count - 1;
        }
        ++self.row;
        if (self.row == self.allDataArray.count - 2) {
            pageNum++;
            [self requestWithPageNum:pageNum];
        }
    }
    PlayList *playlist = self.allDataArray[self.row];
    self.titleLabel.text = playlist.audioName;
    self.mp3URL = playlist.mp3PlayUrl;
    [KAVPlayerManager playWithUrl:self.mp3URL];
    self.progressSlider.maximumValue = playlist.mp3Duration / 1000;
    self.allTime.text = [NSString stringWithFormat:@"%.0f", self.progressSlider.maximumValue / 60];
}

- (void)requestWithPageNum:(NSInteger)pageNum {
    NSString *str = [[SingleList shareSingleList].dict objectForKey:@"ID"];
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@%ld%@", PLAY_LIST_PROGRAM_BASEURL, str, PLAY_LIST_PROGRAM_APPEND,pageNum, PLAY_LIST_PROGRAM_APPENDTWO];
    
    NetWorking *networking = [[NetWorking alloc] init];
    __weak typeof(self)weakSelf = self;
    [networking requestWithURL:URLString Bolck:^(id array) {
        NSDictionary *resultDic = array[@"result"];
        NSArray *dataList = resultDic[@"dataList"];
        for (NSDictionary *dict in dataList) {
            PlayList *playList =  [[PlayList alloc] init];
            [playList setValuesForKeysWithDictionary:dict];
            [weakSelf.allDataArray addObject:playList];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadInputViews];
        });
    }];
}


- (IBAction)upButtonClick:(id)sender {
    if (self.row > 0) {
        --self.row;
        PlayList *playlist = self.allDataArray[self.row];
        self.titleLabel.text = playlist.audioName;
        self.mp3URL = playlist.mp3PlayUrl;
        [KAVPlayerManager playWithUrl:self.mp3URL];
    }
}




- (IBAction)progressSilder:(id)sender {
    [KAVPlayerManager seekToTime:self.progressSlider.value];
}

- (void)playDidFinished {
    [self getMusicByLoopMode];
}

- (void)getMusicByLoopMode {
    switch (_loopMode) {
        case SingleMode:
            [self playAndSetUpViews];
            break;
        case OrderMode:
            self.row++;
            [self playAndSetUpViews];
            break;
        case RandomMode:
            self.row = arc4random() % self.allDataArray.count-1 ;
            [self playAndSetUpViews];
            break;
        default:
            break;
    }
}

- (void)changeTime:(CGFloat)time {
    _progressSlider.value = time;
    self.nowLabel.text = [NSString stringWithFormat:@"%.2f", time / 60];
}

-(void)playAndSetUpViews {
    PlayList *playlist = self.allDataArray[self.row];
    self.mp3URL = playlist.mp3PlayUrl;
    [KAVPlayerManager playWithUrl:self.mp3URL];
}
- (IBAction)shareButton:(id)sender {
    PlayList *playlist = self.allDataArray[self.row];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:playlist.albumPic];
    [UMSocialData defaultData].extConfig.title = playlist.name;
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"577ba4d967e58e5e15002839"
                                      shareText:playlist.audioName
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
    
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (IBAction)collectAction:(id)sender {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    } else  {
        PlayList *playList = self.allDataArray[self.row];
        if (_iscollect == UnCollect)  {
            PlayList *playlist = self.allDataArray[self.row];
            NSString *name = playlist.audioName;
            NSString *ID = [[SingleList shareSingleList].dict objectForKey:@"ID"];
            NSString *updateDay = playlist.updateTime;
            NSString *pic = playList.albumPic;
//            NSData *data = 
            NSString *row = [NSString stringWithFormat:@"%ld", (long)self.row];
            _iscollect = Collected;
            AVObject *object = [AVObject objectWithClassName:@"Album"];
            [object setObject:name forKey:@"name"];
            [object setObject:ID forKey:@"ID"];
            [object setObject:updateDay forKey:@"updateDay"];
            [object setObject: currentUser.username forKey:@"userName"];
            [object setObject:pic forKey:@"pic"];
//            [object setObject:array forKey:@"array"];
            [object setObject:row forKey:@"row"];
            [object fetchWhenSave];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[SingleList shareSingleList].objectIDdic setObject:object.objectId forKey:playlist.audioName];
                }
            }];
            [self.collectButton setImage:[UIImage imageNamed:@"chat_support_blue@2x"] forState:UIControlStateNormal];
        } else {
            AVObject *object = [AVObject objectWithClassName:@"Album" objectId:[[SingleList shareSingleList].objectIDdic objectForKey:playList.audioName]];
            [object deleteInBackground];
            _iscollect = UnCollect;
            [self.collectButton setImage:[UIImage imageNamed:@"chat_support_green@2x"] forState:UIControlStateNormal];
        }
        }
}
- (IBAction)subscribeAction:(id)sender {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    } else  {
        PlayList *playList = self.allDataArray[self.row];
        if (_issubscribe == UnSubscribe)  {
            PlayList *playlist = self.allDataArray[self.row];
            NSString *name = playlist.audioName;
            NSString *ID = [[SingleList shareSingleList].dict objectForKey:@"ID"];
            NSString *updateDay = playlist.updateTime;
            NSString *pic = playList.albumPic;
            _issubscribe = Subsricbe;
            AVObject *object = [AVObject objectWithClassName:@"Subscribe"];
            [object setObject:name forKey:@"name"];
            [object setObject:ID forKey:@"ID"];
            [object setObject:updateDay forKey:@"updateDay"];
            [object setObject: currentUser.username forKey:@"userName"];
            [object setObject:pic forKey:@"pic"];
            [object fetchWhenSave];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[SingleList shareSingleList].subscribeIDdic setObject:object.objectId forKey:playlist.audioName];
                }
            }];
            [self.subscribeButton setImage:[UIImage imageNamed:@"btn_audioplayer_subscribe_on"] forState:UIControlStateNormal];
        } else {
            AVObject *object = [AVObject objectWithClassName:@"Subscribe" objectId:[[SingleList shareSingleList].subscribeIDdic objectForKey:playList.audioName]];
            [object deleteInBackground];
            _issubscribe = UnSubscribe;
            [self.subscribeButton setImage:[UIImage imageNamed:@"btn_audioplayer_subscribe"] forState:UIControlStateNormal];
        }
    }
}
- (IBAction)downLoadActionn:(id)sender {
    if (self.task == nil) {
      
        PlayList *playList = self.allDataArray[self.row];
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *array = [manager contentsOfDirectoryAtPath:caches error:nil];
        for (NSString *str in array) {
            if ([str rangeOfString:playList.audioName].location !=NSNotFound) {
                [self setHUDWithTitle:@"亲，已经下载过啦~~"];
            } else {
                  [self start];
                [self.downLoadButton setImage:[UIImage imageNamed:@"btn_offline_delete_select"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)setHUDWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 5.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)start {
    PlayList *playlist = self.allDataArray[self.row];
    NSURL *url = [NSURL URLWithString:playlist.mp3PlayUrl];
    self.task = [self.session downloadTaskWithURL:url];
    [self.task resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"文件下载完成" message:@"下载成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alterVC addAction:sure];
    [alterVC addAction:cancle];
    [self presentViewController:alterVC animated:YES completion:nil];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSFileManager *manager = [NSFileManager defaultManager];
    PlayList *playlist = self.allDataArray[self.row];
    NSString *file = [caches stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", playlist.audioName]];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager moveItemAtPath:location.path toPath:file error:nil];
    //    NSArray *array =   [manager contentsOfDirectoryAtPath:caches error:nil];
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
