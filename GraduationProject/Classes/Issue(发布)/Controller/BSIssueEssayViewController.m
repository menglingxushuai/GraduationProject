//
//  BSIssueEssayViewController.m
//  GraduationProject
//
//  Created by 孟令旭 on 2017/6/3.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSIssueEssayViewController.h"
#import "ZSSDemoViewController.h"
@interface BSIssueEssayViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)ZSSDemoViewController *zssVc;
@property (weak, nonatomic) IBOutlet UIView *contentEditorView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@end

@implementation BSIssueEssayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
}

#pragma mark - 添加字控制器 
- (void)initLayout {
    _titleTextField.delegate = self;

    NSString *holderText = @"请输入标题";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                       value:[UIColor darkGrayColor]
                       range:NSMakeRange(0, holderText.length)];
   
    _titleTextField.attributedPlaceholder = placeholder;
    
    _zssVc = [ZSSDemoViewController new];
    UIViewController *viewController =  self.zssVc;
    [self addChildViewController:viewController];
    [self.contentEditorView addSubview:viewController.view];
    viewController.view.frame = self.contentEditorView.bounds;
}

#pragma mark - 设置编辑器的大小
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.zssVc.view.frame = self.contentEditorView.bounds;
}

#pragma mark - 完成编辑发布的按钮
- (IBAction)issueLastBtn:(UIButton *)sender {
    
    NSString *style = @"text-align: center;";
    NSString *field = [NSString stringWithFormat:@"<h3 style='%@'>%@</h3>", style, _titleTextField.text];
    NSString *str  = [_zssVc exportHTML];
    NSString *last = [NSString stringWithFormat:@"%@%@", field, str];
    
    AVObject *todo = [AVObject objectWithClassName:@"Todo"];
    [todo setObject:last forKey:@"WZ"];
    [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];// 保存到云端
}



#pragma mark - 返回按钮
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _titleTextField) {
        _zssVc.toolbarHolder.hidden = YES;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _titleTextField) {
        _zssVc.toolbarHolder.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
