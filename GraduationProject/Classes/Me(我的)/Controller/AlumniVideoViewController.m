//
//  AlumniVideoViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/8.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "AlumniVideoViewController.h"
#import "ZFPlayer.h"

@interface AlumniVideoViewController ()<ZFPlayerDelegate>

@property (nonatomic, strong)ZFPlayerView *playerView;


@end

@implementation AlumniVideoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self initLayout];

}

- (void)initLayout {
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"now playing";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
    
    // 设置播放器
    self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        // Here a 16:9 aspect ratio, can customize the video aspect ratio
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    
    // view
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // model
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.fatherView = self.view;
    playerModel.videoURL = [NSURL URLWithString:self.videoStr];
    playerModel.placeholderImage = [UIImage imageNamed: @"zhySb"];
    playerModel.title = self.videoName;
    [self.playerView playerControlView:controlView playerModel:playerModel];
    // delegate
    self.playerView.delegate = self;
    // auto play the video
    [self.playerView autoPlayTheVideo];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
