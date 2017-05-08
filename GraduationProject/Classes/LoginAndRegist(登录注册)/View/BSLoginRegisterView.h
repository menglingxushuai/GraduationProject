//
//  BSLoginRegisterView.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSLoginField.h"

@protocol BSLoginRegisterViewDelegate <NSObject>

- (void)loginAndRegist:(UIButton*)btn;

@end

@interface BSLoginRegisterView : UIView

+ (instancetype)loginView;
+ (instancetype)registerView;

@property (weak, nonatomic) IBOutlet BSLoginField *loginPhone;
@property (weak, nonatomic) IBOutlet BSLoginField *loginPassword;
@property (weak, nonatomic) IBOutlet BSLoginField *registPhone;
@property (weak, nonatomic) IBOutlet BSLoginField *registPassword;
@property (weak, nonatomic) IBOutlet BSLoginField *email;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (nonatomic, weak)id <BSLoginRegisterViewDelegate> loginAndRegistDelegate;

@end
