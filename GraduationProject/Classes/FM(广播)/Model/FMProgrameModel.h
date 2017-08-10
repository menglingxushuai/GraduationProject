//
//  FMProgrameModel.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMProgrameModel : NSObject

@property (nonatomic, strong)NSArray *host;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *updateDay;
@property (nonatomic, strong)NSString *copyrightLabel;
@property (nonatomic, strong)NSString *uploadUserName;
@property (nonatomic, strong)NSArray *keyWords;
@property (nonatomic, strong)NSString *radioDesc;

@property (nonatomic, strong)NSString *audioName;
@property (nonatomic, assign)NSInteger orderNum;
@property (nonatomic, assign)NSInteger listenNum;
@property (nonatomic, assign)NSInteger likedNum;
@property (nonatomic, assign)NSInteger commentNum;
@property (nonatomic, strong)NSString *updateTime;


@property (nonatomic, strong)NSString *userImg;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *utime;
@property (nonatomic, assign)NSInteger praiseNum;

@property (nonatomic, strong)NSString *albumPic;
@property (nonatomic, strong)NSString *mp3PlayUrl;
@property (nonatomic, assign)NSInteger mp3Duration;
@property (nonatomic, strong)NSString *audioId;
@property (nonatomic, strong)NSString *audioPic;
@property (nonatomic, strong)NSString *albumName;
@property (nonatomic, strong)NSString *pic;
@end
