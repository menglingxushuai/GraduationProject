//
//  BSAdViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSAdViewController.h"
#import "BSTabBarViewController.h"
@interface BSAdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (weak, nonatomic) IBOutlet UIImageView *AdImg;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation BSAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建定时器
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_AdImg addGestureRecognizer:tap];
    
    _AdImg.userInteractionEnabled = YES;

}

- (void)timeChange
{
    // 倒计时
    static int i = 3;
    if (i == 0) {
        [self clickJump:nil];
    }
    i--;
    // 设置跳转按钮文字
    [_skipBtn setTitle:[NSString stringWithFormat:@"跳过%d",i] forState:UIControlStateNormal];
}

- (IBAction)clickJump:(UIButton *)sender {
    // 销毁广告界面,进入主框架界面
    BSTabBarViewController *tabBarVc = [BSTabBarViewController new];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    // 干掉定时器
    [_timer invalidate];
    
}


// 点击广告界面调用
- (void)tap
{
    // 跳转到界面 => safari 
    NSURL *url = [NSURL URLWithString:@"http://www.cnblogs.com/menglingxu/"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
            
        }];
    }
}


@end
