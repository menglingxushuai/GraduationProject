//
//  MBProgressHUD+GifHUD.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/8.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (GifHUD)

// 设置Gif
// frame 标记视图的大小
// gifName gif名字
// 目标view
+ (void)setUpGifShowToView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
@end
