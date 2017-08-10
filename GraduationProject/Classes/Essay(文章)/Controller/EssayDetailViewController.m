//
//  EssayDetailViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "EssayDetailViewController.h"
#import "NewsImage.h"
@interface EssayDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation EssayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleViewSet];
    [self requestData];
}

- (void)titleViewSet {
    self.title = @"文章详情";
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
#pragma mark - webView
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight)];
    [self.view addSubview:_webView];
    self.webView.backgroundColor = [UIColor clearColor];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestData {
    __weak typeof(self)weakSelf = self;
    [[BSRequestHandle shareBSRequestHandle] getURL:Essay_ARTICLE_DETAIL_URL(self.model.postid)  parameters:nil succsess:^(id responseObject) {
        NSDictionary *resultDict = responseObject[weakSelf.model.postid];
        [weakSelf.model setValuesForKeysWithDictionary:resultDict];
        self.model.images = [NSMutableArray array];
        for (NSDictionary *dict in resultDict[@"img"]) {
            NewsImage *newsImage = [NewsImage detailImgWithDict:dict];
            [weakSelf.model.images addObject:newsImage];
        }
        // 在webView中显示
        [weakSelf showInWebView];
    } failed:^(id error) {
        
    }];
}


#pragma mark - 在webView中展示
- (void)showInWebView {
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"Details.css" withExtension:nil]];
    [html appendString:@"<style>"];
    
    [html appendString:@"</style>"];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"font-size:14px\">"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}


- (NSString *)touchBody
{
    
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.model.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",[NSString stringWithFormat:@"%@ %@", self.model.source, self.model.ptime]];
    if (self.model.digest.length > 0) {
        [body appendFormat:@"<div class=\"digest\">%@</div>",self.model.digest];
    }
    if (self.model.body != nil) {
        [body appendString:self.model.body];
    }
    
    // 遍历img
    for (NewsImage *detailImgModel in self.model.images) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = kWindowWidth * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        [imgHtml appendFormat:@"<div class=\"alt\">%@</div>", detailImgModel.alt];
        
        
        
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
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
