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
#import "RadioPlayerManager.h"
#import "UMSocial.h"

#define  kRadioPlayerManager [RadioPlayerManager shareRadioPlayerManager]

@interface RadioDisPlayCollectionViewCell ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *centerDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSeverTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightEndTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *displayListButton;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (nonatomic, strong) NSString *urlString;


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
    
    if (kRadioPlayerManager.status == isPlaying) {
        [self.playButton setImage:[[UIImage imageNamed:@"暂停button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    } else {
        [self.playButton setImage:[[UIImage imageNamed:@"播放button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    [self.shareButton setImage:[[UIImage imageNamed:@"ic_broadcastplayer_share_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}
- (IBAction)playAction:(id)sender {
    if (self.urlString) {
        if (kRadioPlayerManager.status != isPlaying) {
            [self initAndPlayMovie:[NSURL URLWithString:self.urlString]];
        } else {
            [self.playButton setImage:[[UIImage imageNamed:@"播放button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            [kRadioPlayerManager pause];
        }
        
    }
}
-(void)initAndPlayMovie:(NSURL *)movieURL
{
    
    [kRadioPlayerManager playWithUrl:movieURL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.contentView.layer addSublayer:playerLayer];
    [kRadioPlayerManager play];
    [self.playButton setImage:[[UIImage imageNamed:@"暂停button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];

}


- (IBAction)shareAction:(id)sender {
    if (self.shareBlock) {
        self.shareBlock();
    }
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
    [kRadioPlayerManager pause];
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
    [self initAndPlayMovie:[NSURL URLWithString:self.urlString]];
    
}

- (void)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    self.leftSeverTimeLabel.text = currentTime;
}



@end
