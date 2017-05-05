//
//  BSScrollerMenuViewController.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSScrollerMenuViewController : UIViewController

@property (strong, nonatomic) NSArray *vcTitleArr;

@property (strong, nonatomic) UIColor *selectColor;

-(void)addChildViewController;

-(void)initializeLinkageListViewController;

@end
