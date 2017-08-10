//
//  BSUserInfo.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUserInfo : NSObject
+ (void)saveDataWithKey:(NSString*)key forData:(NSString*)data;
+ (NSString *)getDataWithKey:(NSString*)key;
+ (void) removeData:(NSString*)key;
@end
