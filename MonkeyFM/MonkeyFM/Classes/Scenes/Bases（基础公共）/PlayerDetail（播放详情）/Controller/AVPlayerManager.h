//
//  AVPlayerManager.h
//  MonkeyFM
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AVPlayerManagerDelegate <NSObject>

//当avplayer播放时间不断改变时 反馈
- (void)changeTime:(CGFloat)time;

//当播放完成时反馈
- (void)playDidFinished;

@end

typedef NS_ENUM(NSUInteger, AVPlayerManagerStatus) {
    isPlaying,//正在播放
    isPaused,//暂停播放
    isStoped,//停止播放
};

@interface AVPlayerManager : NSObject

//代理
@property (nonatomic, weak)id <AVPlayerManagerDelegate> delegate;

//状态
@property (nonatomic,assign)AVPlayerManagerStatus status;

//音量
@property (nonatomic, assign)CGFloat volume;

//声明单例
singleton_interface(AVPlayerManager)

//设置当前想要播放的音乐
- (void) playWithUrl:(NSString *)urlString;

//播放音乐
- (void)play;

//暂停
- (void)pause;

- (void)stop;

//跳转
- (void)seekToTime:(CGFloat)time;

@end

