//
//  FirstCell.m
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/4.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "FirstCell.h"
#import "News.h"
@implementation FirstCell

- (void)setModel:(News *)model {
    _model = model;
    _titleLabel.text = _model.title;
    _titleLabel.alpha = 0.5;
    [_firstImg sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}
@end
