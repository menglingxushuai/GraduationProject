//
//  AlumDetailViewController.m
//  GraduationProject
//
//  Created by 孟令旭 on 2017/6/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "AlumDetailViewController.h"

@interface AlumDetailViewController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation AlumDetailViewController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight)];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI {
    self.title = @"校友发布详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    
    [html appendString:@"<style>"];
    
    [html appendString:@"</style>"];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:self.bodyStr];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
    
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
