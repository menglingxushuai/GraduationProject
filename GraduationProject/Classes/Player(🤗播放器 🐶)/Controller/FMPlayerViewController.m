//
//  FMPlayerViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/3.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "FMPlayerViewController.h"
#import "FMProgrameModel.h"
#import "AVPlayerManager.h"
#import "UIButton+touch.h"
#import "BSLoginAndRegistViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#define KAVPlayerManager [AVPlayerManager shareAVPlayerManager]

@interface FMPlayerViewController ()<AVPlayerManagerDelegate, NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *myImg;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UILabel *beginTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) UIImageView *topImageView;

// 下载
@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSURLSessionDownloadTask *task;
@property (nonatomic,strong) NSData *data;
@property (nonatomic,copy) NSString *dowcLoadStr;
@property (nonatomic,copy) NSString *dowcLoadName;

@property (nonatomic, strong) MPMediaItemArtwork *imgWork;
@end

@implementation FMPlayerViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
#warning 音乐后台播放 - 第二步（也可以写在Appdelegate启动中,然后在- (void)remoteControlReceivedWithEvent:(UIEvent *)event { 方法中监测 点击事件）
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
#warning 音乐 - 释放
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyItem];
    [self initLayout];
}

#pragma mark - 设置返回键 -
- (void)setMyItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化布局 -

- (void)initLayout {
    
    KAVPlayerManager.delegate = self;
    
    _playBtn.selected = NO;
    _bgImg.userInteractionEnabled = YES;
    
    // 毛玻璃
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.8;
    effectView.frame = [UIScreen mainScreen].bounds;
    
    [ _bgImg addSubview:effectView];
    
    // titleView
    UIView *topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [topBkView addSubview:topImageView];
    _topImageView = topImageView;
    self.navigationItem.titleView = topBkView;
    
    FMProgrameModel *model = self.allArr[self.index];
    [self setUIWithModel:model];
    
    
    // 图
    [_bgImg sd_setImageWithURL:[NSURL URLWithString:model.albumPic] placeholderImage:[UIImage imageNamed:@"占位图"]];
    [_myImg sd_setImageWithURL:[NSURL URLWithString:model.albumPic] placeholderImage:[UIImage imageNamed:@"占位图"]];
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:model.albumPic] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.imgWork = [[MPMediaItemArtwork alloc] initWithImage:_bgImg.image];
}

#pragma mark - 播放 下一首 上一首 -
- (IBAction)playBtn:(UIButton *)sender {
    sender.isIgnore = YES;
    if (sender) {
        sender.selected = !sender.selected;
    }
    if (_playBtn.isSelected == NO) {
        [KAVPlayerManager play];
    } else {
        [KAVPlayerManager pause];
    }
    
}

- (IBAction)leftBtn:(id)sender {
    if (self.index > 0) {
        self.index --;
        FMProgrameModel *model = self.allArr[self.index];
        _playBtn.selected = NO;
        [self setUIWithModel:model];
    }
}
- (IBAction)rightBtn:(id)sender {
    NSInteger pageNum = self.allArr.count / 10;
    if (self.index < self.allArr.count - 1) {
        self.index ++;
        if (self.index == self.allArr.count - 2) {
            pageNum++;
            [self requestWithPageNum:pageNum];
        }
        
    }
    FMProgrameModel *model = self.allArr[self.index];
    _playBtn.selected = NO;
    [self setUIWithModel:model];
}

#pragma mark - 下载 -
- (IBAction)downLoadBtn:(id)sender {
    
    NSString *isLogin = [BSUserInfo getDataWithKey:@"IsLogin"];
    if ([isLogin isEqualToString:@"Yes"]) {
        [MBProgressHUD showSuccess:@"视频正在下载"];
        [self downloadBackground];
    } else {
        BSLoginAndRegistViewController *Vc = [BSLoginAndRegistViewController new];
        [self presentViewController:Vc animated:YES completion:nil];
    }
    
}
- (IBAction)changeValue:(UISlider *)sender {
    
    [KAVPlayerManager seekToTime:_mySlider.value];
    
}


- (void)setUIWithModel:(FMProgrameModel *)model {
    
    // 名字
    _myName.text = model.audioName;
    
    //时间
    _mySlider.maximumValue = model.mp3Duration / 1000;
    _endTime.text = [NSString stringWithFormat:@"%.2f", _mySlider.maximumValue / 60];
    // 播放
    [KAVPlayerManager playWithUrl:model.mp3PlayUrl];
    self.dowcLoadStr = model.mp3PlayUrl;
    self.dowcLoadName = model.audioName;
    
    // 配置封面信息
    MAIN(^{
        [self configPlayingInfoWithModel:model];
    });
}


// 请求数据
- (void)requestWithPageNum:(NSInteger)pageNum {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%ld%@", FM_Programe_BaseUrl, self.ID, FM_Programe_AppendNumUrl, (long)pageNum, FM_Programe_Last];
    
    [MBProgressHUD setUpGifShowToView:self.view];
    __weak typeof(self) weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] getURL:urlStr parameters:nil succsess:^(id responseObject) {
        NSDictionary *resultDic = responseObject[@"result"];
        if (resultDic != nil) {
            NSArray *dataArr = resultDic[@"dataList"];
            if (ArrayHave(dataArr)) {
                for (NSDictionary *dic in dataArr) {
                    FMProgrameModel *model = [FMProgrameModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.allArr addObject:model];
                }
                
            }
        }
        MAIN(^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf reloadInputViews];
            
        });
    } failed:^(id error) {
        
    }];
    
    
}

#pragma mark -AVPlayerDelegate-
- (void)changeTime:(CGFloat)time {
    _mySlider.value = time;
    _beginTime.text = [NSString stringWithFormat:@"%.2f", time / 60];
}


- (void)playDidFinished {
    [self rightBtn:nil];
    
}


#pragma mark - 断流下载 -
- (void)downloadBackground
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"download"];
    //系统根据当前性能自动处理后台任务的优先级
    config.discretionary = YES;
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:self.dowcLoadStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _task = [_session downloadTaskWithRequest:request];
    [_task resume];
}

- (void)pushLocalNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    //设置重复通知周期
    localNotification.repeatInterval = kCFCalendarUnitDay;
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    localNotification.alertBody = @"下载完成";
    
    localNotification.applicationIconBadgeNumber++;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    MAIN(^{
        [MBProgressHUD showSuccess:@"下载完成"];
    });
}

- (void)copyFileAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
  
    NSString *toPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", self.dowcLoadName]];
    
    if (![fileManager fileExistsAtPath:toPath]) {
        
        [fileManager copyItemAtPath:path toPath:toPath error:&error];
        
        if (error) {
            NSLog(@"copy error--%@",error.description);
        }
        
    }
}


#warning 未用到
// 暂停下载
- (void)pauseAction:(UIButton *)sender {
    
    if (!_task) {
        return;
    }
    
    [_task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _data = resumeData;
    }];
}

// 继续下载

- (void)resumeAction:(UIButton *)sender {
    
    if (!_data) {
        return;
    }else {
        _task = [_session downloadTaskWithResumeData:_data];
        [_task resume];
    }
    
}

#pragma mark - delegate -

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //    NSLog(@"当前进度%f%%",totalBytesWritten * 1.0 / totalBytesExpectedToWrite * 100);
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //    NSLog(@"file--%@,path--%@",downloadTask.description,location);
    
    [self copyFileAtPath:[location relativePath]];
    
    [self pushLocalNotification];
}


#warning 音乐后台播放 - 第三步监测点击事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
                
            case UIEventSubtypeRemoteControlPause:
                [self playBtn:_playBtn];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self leftBtn:nil];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [self rightBtn:nil];
                break;
            case UIEventSubtypeRemoteControlPlay:
                [self playBtn:_playBtn];
                break;
            default:
                break;
        }
    }
}

#warning 音乐后台播放 - 第四步锁屏封面  (引入系统框架MediaPlayer 然后在播放中的曲目信息改变时调用下面的方法：)
- (void)configPlayingInfoWithModel:(FMProgrameModel *)model {
    
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:model.audioName forKey:MPMediaItemPropertyTitle];
//        [dict setObject:@"曲目艺术家" forKey:MPMediaItemPropertyArtist];
        
        [dict setObject:_imgWork forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nil];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
    
}


@end
