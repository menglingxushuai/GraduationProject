//
//  MBProgressHUD+GifHUD.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/8.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "MBProgressHUD+GifHUD.h"
#import <SDWebImage/UIImage+GIF.h>

@implementation MBProgressHUD (GifHUD)


+ (void)setUpGifShowToView:(UIView *)view
{
    // 使用MBProgress 播放gif 需要自定义视图显示
    // 添加动画
    UIImageView *imageView = [[UIImageView alloc] init];
    // 准备图片数组
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (int i = 1; i <= 5; i++) {
        // 图片名
        NSString *nameStr = [NSString stringWithFormat:@"ic_fresh_%d",i];
        // 创建UIImage对象
        UIImage *image = [UIImage imageNamed:nameStr];
        // 添加到数组中
        [imageArray addObject:image];
    }
    // 设置一组动态图片
    imageView.animationImages = imageArray;
    // 设置动画播放时间
    imageView.animationDuration = 1;
    // 设置重复次数
    imageView.animationRepeatCount = 0;
    // 开始动画
    [imageView startAnimating];
    
    // 自定义视图
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    hud.customView = imageView;
    hud.color = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}


@end
