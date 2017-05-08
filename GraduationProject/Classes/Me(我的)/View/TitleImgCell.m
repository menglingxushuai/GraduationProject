//
//  TitleImgCell.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/5.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "TitleImgCell.h"

@implementation TitleImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
