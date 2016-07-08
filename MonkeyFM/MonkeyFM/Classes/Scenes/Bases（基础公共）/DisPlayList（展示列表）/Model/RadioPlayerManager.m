//
//  RadioPlayerManager.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/5.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioPlayerManager.h"
#import <AVFoundation/AVFoundation.h>



@interface RadioPlayerManager ()


@property (nonatomic, strong) AVPlayer *avPlayer;

@end

@implementation RadioPlayerManager

singletion_implementation(RadioPlayerManager)

- (instancetype)init {
    if (self = [super init]) {
        // 设置播放初始状态
        self.status = isStoped;
        // 使用通知中心监听播放完成,AVPlayerItemDidPlayToEndTimeNotification
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
    return self;
}


-(void)playWithUrl:(NSURL *)movieURL
{
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:movieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    // 如果没有创建新的
    if (!self.avPlayer) {
        self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
        // 如果有替换已有的
    } else {
        [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    }
    
}

- (void)play {
    [self.avPlayer play];
    self.status = isPlaying;
}

- (void)pause
{
    [self.avPlayer pause];
    self.status = isPaused;

}

@end
