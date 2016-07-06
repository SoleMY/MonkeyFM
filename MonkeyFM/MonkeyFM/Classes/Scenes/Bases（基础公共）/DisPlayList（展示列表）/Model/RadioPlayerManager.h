//
//  RadioPlayerManager.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/5.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerManagerDelegate <NSObject>

// 当Player播放时间不断改变时反馈
- (void)changeTime:(CGFloat)time;
// 当播放完成时反馈
- (void)playDidFinished;

@end

typedef NS_ENUM(NSUInteger, PlayerManagerStatus) {
    isPlaying, // 正在播放
    isPaused, // 暂停
    isStoped, // 停止
};

@interface RadioPlayerManager : NSObject
@property (nonatomic, weak) id <PlayerManagerDelegate> delegate;
@property (nonatomic, assign) PlayerManagerStatus status;
@property (nonatomic, assign) BOOL isPlaying;


singleton_interface(RadioPlayerManager)

// 设置当前想要播放的音乐(根据音乐地址播放)
- (void)playWithUrl:(NSURL *)movieURL;

// 播放音乐
- (void)play;

// 暂停音乐
- (void)pause;


@end
