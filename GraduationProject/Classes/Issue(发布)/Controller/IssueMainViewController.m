//
//  IssueMainViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "IssueMainViewController.h"
#import "BSImagePicker.h"
#import "BSIssueEssayViewController.h"
@interface IssueMainViewController ()
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *myImg;
@property (nonatomic, strong) UIButton *issueBtn;
@property (nonatomic, strong) UIButton *issueEditor;

@end

@implementation IssueMainViewController

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = WhiteColor;
        _whiteView.frame = CGRectMake(0, 64, kWindowWidth, kWindowHeight);
    }
    return _whiteView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.width = 43;
        _button.height = 43;
        _button.centerX = kWindow.centerX;
        _button.y = kWindowHeight - 48;
        [_button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(closeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIImageView *)myImg {
    if (!_myImg) {
        _myImg = [UIImageView new];
        _myImg.backgroundColor = [UIColor greenColor];
        _myImg.y = kWindow.height*0.5 - 50;
        _myImg.x = kWindow.width*0.5;
        _myImg.height = 100;
        _myImg.width = 100;
        _myImg.image = [UIImage imageNamed:@"路飞"];
    }
    return _myImg;
}

- (UIButton *)issueBtn {
    if (!_issueBtn) {
        _issueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_issueBtn setTitle:@"发布视频吧" forState:UIControlStateNormal];
        _issueBtn.width = 25;
        _issueBtn.height = 110;
        _issueBtn.y = kWindow.height*0.5 - 55;
        _issueBtn.titleLabel.numberOfLines=0;
        _issueBtn.x = kWindow.width*0.5 - 25;
        _issueBtn.layer.cornerRadius = 5;
        _issueBtn.backgroundColor = MainColor;
        [_issueBtn addTarget:self action:@selector(issueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _issueBtn;
}

- (UIButton *)issueEditor {
    if (!_issueEditor) {
        _issueEditor = [UIButton buttonWithType:UIButtonTypeCustom];
        [_issueEditor setTitle:@"发布文章吧" forState:UIControlStateNormal];
        _issueEditor.width = 25;
        _issueEditor.height = 110;
        _issueEditor.y = kWindow.height*0.5 - 55;
        _issueEditor.titleLabel.numberOfLines=0;
        _issueEditor.x = kWindow.width*0.5 - 60;
        _issueEditor.layer.cornerRadius = 5;
        _issueEditor.backgroundColor = MainColor;
        [_issueEditor addTarget:self action:@selector(issueEditorBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _issueEditor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    // 4.设置whiteView
    [self setupWhiteView];
}


- (void)initLayout {
}

#pragma mark - 白色view
- (void)setupWhiteView {
    
    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.button];
    [self.view addSubview:self.myImg];
    [self.view addSubview:self.issueBtn];
    [self.view addSubview:self.issueEditor];
}

- (void)closeButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)issueBtnClick {
    BSImagePicker *picker = [[BSImagePicker alloc] init];
    [self presentViewController:picker animated:YES completion:nil];
}

// 跳转发布文章界面
- (void)issueEditorBtn {
    [self presentViewController:[BSIssueEssayViewController new] animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
