//
//  ToolForRubbish.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "ToolForRubbish.h"

@implementation ToolForRubbish
//获取硬盘大小
+ (CGFloat)getDiskSize
{
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 初始化文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    // 获取lib下所有路径
    NSArray *libAllPath = [manager subpathsAtPath:libPath];
    NSInteger size = 0;
    for (NSString *path in libAllPath) {
        if (![path containsString:@"Preferences"]) {
            //把路径拼接全
            NSString *pathA = [libPath stringByAppendingPathComponent:path];
            //获取文件的所有信息
            NSDictionary *fileAttri = [manager attributesOfItemAtPath:pathA error:nil];
            //获取文件大小
            size += [fileAttri[@"NSFileSize"] integerValue];
        }
    }
    return size/1024.0/1024.0;
}

//清除缓存
+ (void)clearDisk
{
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    //初始化文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    //获取lib下所有路径
    NSArray *libAllPath = [mgr subpathsAtPath:libPath];
    
    for (NSString *path in libAllPath) {
        if (![path containsString:@"Preferences"]) {
            //把路径拼接全
            NSString *pathA = [libPath stringByAppendingPathComponent:path];
            //移除文件
            [mgr removeItemAtPath:pathA error:nil];
        }
    }
}
@end
