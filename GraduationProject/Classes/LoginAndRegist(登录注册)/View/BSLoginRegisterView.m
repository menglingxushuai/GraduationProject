//
//  BSLoginRegisterView.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSLoginRegisterView.h"

@implementation BSLoginRegisterView

// 越复杂的界面,封装 有特殊效果界面,也需要封装

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BSLoginRegisterView" owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BSLoginRegisterView" owner:nil options:nil] lastObject];
}
- (IBAction)loginAndRegist:(UIButton *)sender {
    if (self.loginAndRegistDelegate && [self.loginAndRegistDelegate respondsToSelector:@selector(loginAndRegist:)]) {
        [self.loginAndRegistDelegate loginAndRegist:sender];
    }
    
}


@end
