//
//  BSNavigationViewController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "BSNavigationViewController.h"
@interface BSNavigationViewController ()

@end

@implementation BSNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = MainColor;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:WhiteColor};
    [self.navigationBar setTintColor:WhiteColor];
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
