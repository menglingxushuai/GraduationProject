//
//  AVPlayerManager.m
//  MonkeyFM
//
//  Created by 孟令旭 on 16/7/4.
//  Copyright © 2016年 孟令旭. All rights reserved.
//

#import "AVPlayerManager.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerManager ()

@property (nonatomic, strong)AVPlayer *avPlayer;
@property (nonatomic, strong)NSTimer *timer;

@end
@implementation AVPlayerManager

singletion_implementation(AVPlayerManager)


- (instancetype)init {
    self = [super init];
    if (self) {
        self.status = isStoped;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _timer.fireDate = [NSDate distantFuture];
    }
    return self;
}

- (void)timerAction:(NSTimer *)timer {
    if ([_delegate respondsToSelector:@selector(changeTime:)]) {
        //        传回我当前的播放时间
        //        使用CMTime.value / timescale（时间的单位） = seconds 得到秒
        CGFloat currentTime = _avPlayer.currentTime.value / _avPlayer.currentTime.timescale;
        [_delegate changeTime:currentTime];
        
    }
}

//当播放结束时执行的方法
- (void)playerItemDidPlayFinished {
    if ([_delegate respondsToSelector:@selector(playDidFinished)]) {
        [_delegate playDidFinished];
    }
}

//设置当前想要播放的音乐
- (void) playWithUrl:(NSString *)urlString{
    if (self.isRadio) {
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:urlString] options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        // 如果没有创建新的
        if (!self.avPlayer) {
            self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
            // 如果有替换已有的
        } else {
            [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
        }
    }else {
        //    创建一个音乐播放的item
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
        if (!_avPlayer) {
            //        创建新的进行播放
            _avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        } else {
            //        替换当前的播放item
            [_avPlayer replaceCurrentItemWithPlayerItem:item];
        }
        [self play];
    }
}

//播放音乐
- (void)play {
    [_avPlayer play];
    if (!self.isRadio) {
        _timer.fireDate = [NSDate distantPast];
    }
    
    self.status = isPlaying;
}

//暂停
- (void)pause {
    [_avPlayer pause];
    if (!self.isRadio) {
        _timer.fireDate = [NSDate distantFuture];
    }
    self.status = isPaused;
}

- (void)stop {
    _avPlayer = nil;
}

//跳转
- (void)seekToTime:(CGFloat)time {
    //    value = senconds * timescale
    [_avPlayer seekToTime:CMTimeMake(time * _avPlayer.currentTime.timescale, _avPlayer.currentTime.timescale)];
}

//改变音量
- (void)setVolume:(CGFloat)volume {
    _volume = volume;
    _avPlayer.volume = _volume;
}

#pragma mark 设置后台播放音乐
- (void)initialize{
    //后台播放，设置会话类型。
    AVAudioSession *session = [AVAudioSession sharedInstance];
    //而且要激活，音频会话。
    [session setActive:YES error:nil];
    //类型是:播放和录音。
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}

@end
