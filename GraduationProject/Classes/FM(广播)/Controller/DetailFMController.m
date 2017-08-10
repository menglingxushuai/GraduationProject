//
//  DetailFMController.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "DetailFMController.h"
#import "DetailSubViewController.h"
#import "Detail1SubViewController.h"
#import "Detail2SubViewController.h"
@interface DetailFMController ()

@end

@implementation DetailFMController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];

}

- (void)initLayout {
    self.title = @"FM";
    self.selectColor = RGB(82, 203, 203);
    [self initializeLinkageListViewController];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"navigationButtonReturn-1" highImage:nil target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addChildViewController{
    
    self.vcTitleArr = @[@"节目", @"评论", @"详情"];
    if (ArrayHave(self.vcTitleArr)) {
        
        for (int i = 0; i < self.vcTitleArr.count; i++) {
            
            switch (i) {
                case 0:{
                    DetailSubViewController * vc = [[DetailSubViewController alloc] init];
                    vc.ID = self.ID;
                    vc.title  =  self.vcTitleArr[i];
                    [self addChildViewController:vc];
                    break;
                }
                case 1:{
                    Detail1SubViewController * vc = [[Detail1SubViewController alloc] init];
                    vc.ID = self.ID;
                    vc.title  =  self.vcTitleArr[i];
                    [self addChildViewController:vc];
                    break;
                }
                case 2:{
                    Detail2SubViewController * vc = [[Detail2SubViewController alloc] init];
                    vc.ID = self.ID;
                    vc.title  =  self.vcTitleArr[i];
                    [self addChildViewController:vc];
                    break;
                }
                default:
                    break;
            }
            
        }
    }
}

@end
