//
//  FMDetailModel.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDetailModel : NSObject

/// 标题
@property (nonatomic, strong) NSString *name;

/// 图片
@property (nonatomic, strong) NSString *pic;

/// 内容
@property (nonatomic, strong) NSString *desc;

/// 评论数
@property (nonatomic, strong) NSString *hot;

/// 时间
@property (nonatomic, strong) NSString *utime;

/// id
@property (nonatomic, strong) NSString *Id;

@end
