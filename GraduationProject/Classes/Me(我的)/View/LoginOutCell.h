//
//  LoginOutCell.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/5.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginOutCellDelegete <NSObject>

- (void)logOut:(UIButton*)btn;


@end

@interface LoginOutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *loginOut;
@property (nonatomic, weak)id <LoginOutCellDelegete> outdelegate;
@end
