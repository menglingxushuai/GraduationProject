//
//  AlumniVideoViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/8.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "AlumniVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface AlumniVideoViewController ()
/// 控制视频播放的控件
/// 声明播放视频控件的属性[既可以播放视频也可以播放音频]
@property (nonatomic, strong)AVPlayer *player;
/// 播放的总时长
@property (nonatomic, assign)CGFloat sumPlayOperation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOfPlayBtn;

@end

@implementation AlumniVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置播放的url
    NSURL *url = [NSURL URLWithString:self.videoStr];
    
    // 设置的播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    // 初始化player对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    // 设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // 设置播放页面的大小
    layer.frame = CGRectMake(0, 84, kWindowWidth, kWindowHeight*0.6);
    // 设置背景颜色
//    layer.backgroundColor = [UIColor cyanColor].CGColor;
    // 设置播放窗口和当前视图之间的比例显示内容
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 添加播放视图到self.view上
    [self.view.layer addSublayer:layer];
    // 设置播放进度的默认值
    // 设置播放的默认音量
    self.player.volume = 1.0f;

}


#pragma mark - 开始播放按钮的响应方法
- (IBAction)playBtn:(UIButton *)sender {
    [self.player play];
}

#pragma mark - 暂停播放按钮的响应方法
- (IBAction)pauseBtn:(id)sender {
    [self.player pause];
}


#pragma mark - 更新约束
- (void)updateViewConstraints {
    [super updateViewConstraints];
    _topOfPlayBtn.constant = kWindowHeight *0.6 + 84 + 20;
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
