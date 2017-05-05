//
//  BSScrollerMenuViewController.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSScrollerMenuViewController.h"


static CGFloat const titleScvH = 44;/** 文字栏高度  */
static CGFloat const MaxScale = 1.1;/** 选中文字放大  */

@interface BSScrollerMenuViewController ()<UIScrollViewDelegate>

/** 标签按钮  */
@property (strong,nonatomic) NSMutableArray *titleButtonsArr;

/** 文字scrollView（顶端标题栏）  */
@property (nonatomic, strong) UIScrollView *titleScrollView;

/** 控制器scrollView  */
@property (nonatomic, strong) UIScrollView *contentScrollView;

/** 标签文字  */
//@property (nonatomic ,strong) NSArray * titlesArr;
/** 选中的按钮  */
@property (nonatomic ,strong) UIButton * selectedBtn;

/** 选中的按钮下边的线条  */
@property (nonatomic, strong)UIView * lineView;

@end

@implementation BSScrollerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)initializeLinkageListViewController{
    
    //外部更新标签的时候，先要移除之前添加的控制器和视图
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromParentViewController];
    }];
    
    [self addChildViewController];
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.contentScrollView];
    
    [self addTitleButton];
    self.contentScrollView.contentSize = CGSizeMake(_vcTitleArr.count * kWindowWidth, 0);
    
}

-(NSMutableArray *)titleButtonsArr{
    
    if(!_titleButtonsArr){
        
        _titleButtonsArr = [NSMutableArray arrayWithCapacity:10];
        
    }
    
    return _titleButtonsArr;
}

-(UIScrollView *)titleScrollView{
    
    if(!_titleScrollView){
        
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, titleScvH)];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        _titleScrollView.pagingEnabled = YES;
        _titleScrollView.showsHorizontalScrollIndicator  = NO;
        _titleScrollView.showsVerticalScrollIndicator  = NO;
        _titleScrollView.delegate = self;
    }
    
    return _titleScrollView;
}

-(UIScrollView *)contentScrollView{
    
    if(!_contentScrollView){
        
        CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
        CGRect rect  = CGRectMake(0, y, kWindowWidth, kWindowHeight - titleScvH);
        
        _contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
        
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator  = NO;
        _contentScrollView.delegate = self;
        
    }
    
    return _contentScrollView;
}

-(void)addChildViewController{
    
    
}

-(void)addTitleButton{
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat w = kWindowWidth / _vcTitleArr.count;
    if (w < 80) {//标题按钮的宽度  >= 80
        
        w = 80;
    }
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 2, w, titleScvH - 6);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rect;
        
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:RGB(63, 63, 63) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.titleButtonsArr addObject:btn];
        
        [self.titleScrollView addSubview:btn];
        
        if (i == 0){//默认选中第一个
            
            [self titleClick:btn];
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);//titleScrollView的滑动范围
    
    //增加下边的下划线（视具体情况可省略）
    UIView * covertView = [[UIView alloc] initWithFrame:CGRectMake(0, titleScvH - 1, self.titleScrollView.contentSize.width, 1)];
    covertView.backgroundColor = RGB(242, 242, 242);
    [self.titleScrollView addSubview:covertView];
    
    if (self.titleScrollView.contentSize.width/_vcTitleArr.count < 80) {
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleScvH - 2, 80, 2)];
    }else{
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleScvH - 2, self.titleScrollView.contentSize.width/_vcTitleArr.count, 2)];
    }
    
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self.titleScrollView addSubview:self.lineView];
    
    
}

-(void)titleClick:(UIButton *)sender{
    
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    CGFloat x  = i * kWindowWidth;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self setUpOneChildController:i];
}

-(void)selectTitleBtn:(UIButton *)btn{
    
    [self.selectedBtn setTitleColor:RGB(63, 63, 63) forState:UIControlStateNormal];
    //    self.selectedBtn.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:_selectColor forState:UIControlStateNormal];
    //    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    
    //缩放动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = [NSNumber numberWithFloat:1.2f];
    animation1.toValue  = [NSNumber numberWithFloat:1.0f];
    animation1.duration = 0.3;
    animation1.repeatCount = 1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.autoreverses = NO;
    [self.selectedBtn.titleLabel.layer addAnimation:animation1 forKey:@"animation1"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:1.0f];
    animation2.toValue  = [NSNumber numberWithFloat:1.2f];
    animation2.duration = 0.3;
    animation2.repeatCount = 1;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    animation2.autoreverses = YES;
    [btn.titleLabel.layer addAnimation:animation2 forKey:@"animation2"];
    
    self.selectedBtn = btn;
    self.lineView.centerX = btn.centerX;//使下划线的中心跟随 当前选中的按钮
    
    [self setupTitleCenter:btn];
}

//更新 按钮的中心位置
-(void)setupTitleCenter:(UIButton *)sender
{
    //保证数量较少时不会产生异常的偏移！
    if (self.titleScrollView.contentSize.width <= kWindowWidth) {
        
        return;
    }
    
    CGFloat offset = sender.center.x - kWindowWidth * 0.5;
    if (offset < 0) {
        
        offset = 0;
    }
    
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - kWindowWidth;
    
    if (offset > maxOffset) {
        
        offset = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    
}

//给contentScrollView添加当前某个需要显示的 ViewController
-(void)setUpOneChildController:(NSInteger)index{
    
    CGFloat x  = index * kWindowWidth;
    UIViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {//判断是否是父视图
        return;
    }
    
    vc.view.frame = CGRectMake(x, 0, kWindowWidth, kWindowHeight - self.contentScrollView.frame.origin.y);
    
    [self.contentScrollView addSubview:vc.view];//将子ViewController 的 View 添加到  contentScrollView 上
    
    
}

#pragma mark - UIScrollView  delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.contentScrollView){
        
        NSInteger i  = self.contentScrollView.contentOffset.x / kWindowWidth;
        [self selectTitleBtn:self.titleButtonsArr[i]];
        [self setUpOneChildController:i];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.contentScrollView){
        
        CGFloat offsetX  = scrollView.contentOffset.x;
        NSInteger leftIndex  = offsetX / kWindowWidth;
        NSInteger rightIdex  = leftIndex + 1;
        
        UIButton *leftButton = self.titleButtonsArr[leftIndex];
        UIButton *rightButton  = nil;
        if (rightIdex < self.titleButtonsArr.count) {
            
            rightButton  = self.titleButtonsArr[rightIdex];
        }
        
        CGFloat scaleR  = offsetX / kWindowWidth - leftIndex;
        CGFloat scaleL  = 1 - scaleR;
        CGFloat transScale = MaxScale - 1;
        leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
        rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
        
        //修改下划线的frame
        //self.lineView.transform  = CGAffineTransformMakeTranslation((offsetX * (self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    }
    
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
