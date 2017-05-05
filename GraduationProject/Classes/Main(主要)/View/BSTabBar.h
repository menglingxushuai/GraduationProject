//
//  BSTabBar.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/5.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTabBar;
@protocol BSTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarClickPlusButton:(BSTabBar *)tabBar;

@end

@interface BSTabBar : UITabBar

@property (nonatomic, weak) id<BSTabBarDelegate>BsDelegate;

@end
