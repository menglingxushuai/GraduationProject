//
//  NewsPSetTableViewCell.m
//  ShowNews
//
//  Created by YYP on 16/7/2.
//  Copyright © 2016年 YZZL. All rights reserved.
//

#import "NewsPSetTableViewCell.h"

@implementation NewsPSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _widthImg.constant = kWindowWidth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
