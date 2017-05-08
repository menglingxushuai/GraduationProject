//
//  IssueMainViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/6.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "IssueMainViewController.h"
#import "FMImagePicker.h"
@interface IssueMainViewController ()
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *myImg;
@property (nonatomic, strong) UIButton *issueBtn;

@end

@implementation IssueMainViewController

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
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = WhiteColor;
    self.whiteView.frame = CGRectMake(0, 64, kWindowWidth, kWindowHeight);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.width = 43;
    button.height = 43;
    button.centerX = kWindow.centerX;
    button.y = kWindowHeight - 48;
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeButton) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    
    self.myImg = [UIImageView new];
    self.myImg.backgroundColor = [UIColor greenColor];
    self.myImg.y = kWindow.height*0.5 - 50;
    self.myImg.x = kWindow.width*0.5;
    self.myImg.height = 100;
    self.myImg.width = 100;
    self.myImg.image = [UIImage imageNamed:@"路飞"];
    
    self.issueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.issueBtn setTitle:@"发布视频吧" forState:UIControlStateNormal];
    self.issueBtn.width = 25;
    self.issueBtn.height = 110;
    self.issueBtn.y = kWindow.height*0.5 - 55;
    self.issueBtn.titleLabel.numberOfLines=0;
    self.issueBtn.x = kWindow.width*0.5 - 25;
    self.issueBtn.layer.cornerRadius = 5;
    self.issueBtn.backgroundColor = MainColor;
    [self.issueBtn addTarget:self action:@selector(issueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.button];
    [self.view addSubview:self.myImg];
    [self.view addSubview:self.issueBtn];

}

- (void)closeButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)issueBtnClick {
    DLog(@"我是发布");
    FMImagePicker *picker = [[FMImagePicker alloc] init];
    [self presentViewController:picker animated:YES completion:nil];
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
