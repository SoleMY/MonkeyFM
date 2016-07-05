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

#define KAVPlayerManager [AVPlayerManager shareAVPlayerManager]

typedef NS_ENUM(NSUInteger, LoopMode) {
    SingleMode,//单曲
    RandomMode,//随机
    OrderMode,//顺序
};


@interface PlayerDetailViewController ()<AVPlayerManagerDelegate>
{
    LoopMode _loopMode; //用来记录当前的播放模式
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

@end

@implementation PlayerDetailViewController


- (NSMutableArray *)allDataArray {
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)viewDidLoad {
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
    _loopMode = SingleMode;
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
        [KAVPlayerManager playWithUrl:self.mp3URL];
    }
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)initLayout {
    PlayList *playlist = self.allDataArray[self.row];
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

- (void)animation {
    [UIView transitionWithView:self.view duration:1 options:0 animations:^{
        self.firstImage.frame = self.secondImage.frame;
        self.secondImage.frame = self.thirdImage.frame;
        self.thirdImage.frame = self.fourthImage.frame;
        self.fourthImage.frame = self.firstImage.frame;
    } completion:^(BOOL finished) {
        
    }];
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
    [networking requestWithURL:URLString Bolck:^(id array) {
        NSDictionary *resultDic = array[@"result"];
        NSArray *dataList = resultDic[@"dataList"];
        for (NSDictionary *dict in dataList) {
            PlayList *playList =  [[PlayList alloc] init];
            [playList setValuesForKeysWithDictionary:dict];
            [self.allDataArray addObject:playList];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadInputViews];
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
//
- (void)getMusicByLoopMode {
    switch (_loopMode) {
        case SingleMode:
//            self.row;
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
            NSLog(@"未知模式，请设置");
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
