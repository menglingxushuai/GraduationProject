//
//  BSTabBarViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSTabBarViewController.h"
#import "BSNavigationViewController.h"
#import "VideoViewController.h"
#import "EssayViewController.h"
#import "FMViewController.h"
#import "MeViewController.h"
#import "UIImage+Image.h"
#import "BSTabBar.h"
@interface BSTabBarViewController ()<BSTabBarDelegate>
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *myImg;
@property (nonatomic, strong) UIButton *issueBtn;

@end

@implementation BSTabBarViewController

// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    // 3.自定义tabBar
//    [self setupTabBar];
    // 4.设置whiteView
    [self setupWhiteView];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    BSTabBar *tabBar = [[BSTabBar alloc] init];
    tabBar.BsDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}


/*
 Changing the delegate of a tab bar 【managed by a tab bar controller】 is not allowed.
 被UITabBarController所管理的UITabBar的delegate是不允许修改的
 */

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 视频
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    BSNavigationViewController *nav = [[BSNavigationViewController alloc] initWithRootViewController:videoVc];
    
    [self addChildViewController:nav];
    
    // 广播
    FMViewController *fmVc = [[FMViewController alloc] init];
    BSNavigationViewController *nav3 = [[BSNavigationViewController alloc] initWithRootViewController:fmVc];
    [self addChildViewController:nav3];
    
    // 文章
    EssayViewController *essayVc = [[EssayViewController alloc] init];
    BSNavigationViewController *nav1 = [[BSNavigationViewController alloc] initWithRootViewController:essayVc];
    [self addChildViewController:nav1];
    
    // 我
    MeViewController *meVc = [[MeViewController alloc] init];
    // 加载箭头指向控制器
    BSNavigationViewController *nav4 = [[BSNavigationViewController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    // 0:视频
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"视频";
    nav.tabBarItem.image = [UIImage xmg_circleImageNamed:@"video"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"video"];
    
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 1:FM
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"FM";
    nav1.tabBarItem.image = [UIImage xmg_circleImageNamed:@"fm"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"fm"];
    
    // 3.文章
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"文章";
    nav3.tabBarItem.image = [UIImage xmg_circleImageNamed:@"文章"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"文章"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage xmg_circleImageNamed:@"mine"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"mine"];
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
    self.myImg.x = kWindow.width*0.5 + 50;
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
}

- (void)tabBarClickPlusButton:(BSTabBar *)tabBar {
    __weak typeof(self)mySelf = self;
    [UIView animateWithDuration:2 delay:0.1 usingSpringWithDamping:0.08 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        mySelf.myImg.y = kWindow.height*0.5 - 50;
        mySelf.myImg.x = kWindow.width*0.5;
        mySelf.myImg.height = 100;
        mySelf.myImg.width = 100;
    } completion:^(BOOL finished) {
        
    }];
    [kWindow addSubview:self.whiteView];
    [kWindow addSubview:self.button];
    [kWindow addSubview:self.myImg];
    [kWindow addSubview:self.issueBtn];
}

- (void)closeButton {
    [self.whiteView removeFromSuperview];
    [self.button removeFromSuperview];
    [self.myImg removeFromSuperview];
    [self.issueBtn removeFromSuperview];
}

- (void)issueBtnClick {
    DLog(@"我是发布");
}
@end
