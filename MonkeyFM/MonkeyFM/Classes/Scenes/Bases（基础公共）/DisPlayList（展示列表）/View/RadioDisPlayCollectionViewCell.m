//
//  RadioDisPlayCollectionViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioDisPlayCollectionViewCell.h"
#import "RadioDisplayModel.h"
#import "UIImageView+LBBlurredImage.h"
#import "RadioDisplayPlayModel.h"
#import <AVFoundation/AVFoundation.h>


@interface RadioDisPlayCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *centerDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSeverTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightEndTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *displayListButton;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) NSString *urlString;
// 记录播放状态
@property (nonatomic, assign) BOOL isPlaying;

@end
@implementation RadioDisPlayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.centerDesLabel sizeToFit];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(getCurrentTime) userInfo:nil repeats:YES];
    self.isPlaying = NO;
}
- (IBAction)playAction:(id)sender {
    if (self.urlString) {
        if (!self.isPlaying) {
            [self initAndPlayMovie:[NSURL URLWithString:self.urlString]];
        } else {
            [self.avPlayer pause];
            [self.playButton setImage:[[UIImage imageNamed:@"播放button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            self.isPlaying = NO;
        }
        
    }
}
-(void)initAndPlayMovie:(NSURL *)movieURL
{
    
        AVAsset *movieAsset    = [AVURLAsset URLAssetWithURL:movieURL options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        if (!self.avPlayer) {
            self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
        } else {
            [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
        }
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.contentView.layer addSublayer:playerLayer];
        [self.avPlayer play];
        [self.playButton setImage:[[UIImage imageNamed:@"暂停button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.isPlaying = YES;

}

- (IBAction)lastAction:(id)sender {
}

- (IBAction)nextAction:(id)sender {
}

- (IBAction)showDisplayListAction:(id)sender {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.5;
    
    UIViewController *VC = [self getCurrentVC];
    
    [UIView animateWithDuration:1.0f animations:^{
        [VC.view addSubview:view];
    }];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }
    else {
        result = window.rootViewController;
    }
    return result;
}
- (void)bindModel:(RadioDisplayModel *)model
{
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];

}

- (void)dealloc
{
    // 当对象被销毁时，销毁定时器
    [self.timer invalidate];
}

- (void)bindPlayModel:(RadioDisplayPlayModel *)playModel
{
    self.centerDesLabel.text = playModel.title;
    if (self.centerDesLabel == nil) {
        self.centerDesLabel.text = @"暂无节目信息";
    }
    self.rightEndTimeLabel.text = playModel.endTime;
    self.urlString = playModel.playUrl;
}

- (void)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    self.leftSeverTimeLabel.text = currentTime;
}



@end
