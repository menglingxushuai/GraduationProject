//
//  LoginOutCell.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/5.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "LoginOutCell.h"

@implementation LoginOutCell
- (IBAction)loginOutAction:(UIButton *)sender {
    if (self.outdelegate && [self.outdelegate respondsToSelector:@selector(logOut:)]) {
        [self.outdelegate logOut:sender];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
