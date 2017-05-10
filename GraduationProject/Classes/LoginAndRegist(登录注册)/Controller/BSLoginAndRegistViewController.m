//
//  BSLoginAndRegistViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSLoginAndRegistViewController.h"
#import "BSLoginRegisterView.h"
#define kTop 100
#define kHeight 300
/*
 屏幕适配:
 1.一个view从xib加载,需不需在重新固定尺寸 一定要在重新设置一下
 
 2.在viewDidLoad设置控件frame好不好,开发中一般在viewDidLayoutSubviews布局子控件
 */

@interface BSLoginAndRegistViewController ()<BSLoginRegisterViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leaCons;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) BSLoginRegisterView *loginView;
@property (nonatomic, strong) BSLoginRegisterView *registView;
@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation BSLoginAndRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSLoginRegisterView *loginView = [BSLoginRegisterView loginView];
    loginView.loginAndRegistDelegate = self;
    [self.bgView addSubview:loginView];
    _loginView = loginView;
    BSLoginRegisterView *registView = [BSLoginRegisterView registerView];
    registView.loginAndRegistDelegate = self;
    [self.bgView addSubview:registView];
    _registView = registView;
    
    
    NSString *userName = [BSUserInfo getDataWithKey:@"UserName"];
    if ([NSString isBlankString:userName] == NO) {
        _loginView.loginPhone.text = userName;
    }
    _loginButton = loginView.loginBtn;
    
}
#pragma mark - 关闭
- (IBAction)closeBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 登录注册
- (IBAction)clickRegister:(UIButton *)sender {
    _currentBtn = sender;
    _currentBtn.isIgnore = YES;
    sender.selected = !sender.selected;
    
    // 平移中间view
    // 平移中间view
    _leaCons.constant = _leaCons.constant == 0? -self.bgView.width * 0.5:0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}


// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews
{
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    _loginView.frame = CGRectMake(0, kTop, self.bgView.width*0.5, kHeight);
    
    // 设置注册view
    _registView.frame = CGRectMake(self.bgView.width*0.5, kTop - 50,self.bgView.width*0.5, kHeight);
   
    
}

- (void)loginAndRegist:(UIButton*)btn{
    switch (btn.tag) {
        case 100:{
            [self loginAction];
            break;
        }
        case 101:{
            [self registAction];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 登录
-(void)loginAction {
    NSString *username = _loginView.loginPhone.text;
    NSString *password = _loginView.loginPassword.text;
    BOOL userOk = [ToolForReguar checkUsername:username];
    BOOL passwordOk = [ToolForReguar checkPassWord:password];
    if (userOk == NO) {
        [MBProgressHUD showSuccess:@"用户名有误"];
    } else if (passwordOk == NO) {
        [MBProgressHUD showSuccess:@"密码有误"];
    } else if (userOk == YES && passwordOk == YES) {
        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
            if (error) {
                [self faildAnimation];
                if (error.code == 210) {
                    MAIN(^{
                        [MBProgressHUD showSuccess:@"密码与用户名不符合"];
                    });
                } else if (error.code == 211) {
                    MAIN(^{
                        [MBProgressHUD showSuccess:@"用户名不存在"];
                    });
                }
            } else {
                        [BSUserInfo saveDataWithKey:@"UserName" forData:username];
                [self closeBtn:nil];
            }
        }];
    }
}

#pragma mark - 注册
- (void)registAction {
    BOOL phoneOk = [ToolForReguar checkUsername:_registView.registPhone.text];
    BOOL passwordOk = [ToolForReguar checkPassWord:_registView.registPassword.text];
    BOOL emailOk = [ToolForReguar isEmailAddress:_registView.email.text];
    if (phoneOk == NO) {
        [MBProgressHUD showSuccess:@"请输入正确的用户名"];
    } else if (passwordOk == NO) {
        [MBProgressHUD showSuccess:@"请输入正确的密码"];
    } else if (emailOk == NO) {
        [MBProgressHUD showSuccess:@"请输入正确的邮箱"];
    } else if (phoneOk == YES && passwordOk == YES && emailOk == YES) {
        AVUser *user = [AVUser user];
        user.username = _registView.registPhone.text;
        user.password = _registView.registPassword.text;
        user.email = _registView.email.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                MAIN(^{
                    _registView.registPhone.text = @"";
                    _registView.registPassword.text = @"";
                    _registView.email.text = @"";
                    [MBProgressHUD showSuccess:@"注册成功"];
                    AFTER(^{
                        [self clickRegister:_currentBtn];
                    });
                });
                
            } else {
                if (error.code == 203) {
                    MAIN(^{
                        [MBProgressHUD showSuccess:@"邮箱已被占用"];
                    });
                } else if (error.code == 202) {
                    MAIN(^{
                        [MBProgressHUD showSuccess:@"用户名已被占用"];
                    });
                }
            }
        }];
    }
}

#pragma mark - 键盘回收
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - 阻尼动画
- (void)faildAnimation
{
    __weak typeof(self) weakSelf = self;
    
    //        这里模拟的是登录失败的状况。设置一个阻尼动画，失败的时候登录按钮进行晃动
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.loginButton.bounds = CGRectMake(weakSelf.loginButton.bounds.origin.x - 20, weakSelf.loginButton.bounds.origin.y, weakSelf.loginButton.bounds.size.width, weakSelf.loginButton.bounds.size.height);
        //            在动画没有播放完成之前，关闭按钮的交互
        [weakSelf.loginButton setEnabled:NO];
        
    } completion:^(BOOL finished) {
        //            动画播放完成后，重新开启按钮的交互
        [weakSelf.loginButton setEnabled:YES];
        //            把登录按钮的位置进行复原
        weakSelf.loginButton.bounds = CGRectMake(weakSelf.loginButton.bounds.origin.x + 20, weakSelf.loginButton.bounds.origin.y, weakSelf.loginButton.bounds.size.width, weakSelf.loginButton.bounds.size.height);
        dispatch_async(dispatch_get_main_queue(), ^{
            // do something
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
