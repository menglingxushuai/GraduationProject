//
//  ToolForReguar.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolForReguar : NSObject
+ (BOOL)valiMobile:(NSString *)mobile;
+ (BOOL)checkPassWord:(NSString *) password;
+ (BOOL)checkUsername:(NSString *)userName;
+ (BOOL)isEmailAddress:(NSString *)email;
@end
