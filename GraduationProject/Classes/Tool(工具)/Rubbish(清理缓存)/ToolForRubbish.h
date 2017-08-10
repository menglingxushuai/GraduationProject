//
//  ToolForRubbish.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolForRubbish : NSObject

//获取硬盘大小
+ (CGFloat)getDiskSize;
//清除缓存
+ (void)clearDisk;

@end
