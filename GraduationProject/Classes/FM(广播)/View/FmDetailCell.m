//
//  FmDetailCell.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "FmDetailCell.h"
#import "FMDetailModel.h"
@implementation FmDetailCell

- (void)setModel:(FMDetailModel *)model {
    _model = model;
    [self.Img sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.title.text = _model.name;
    self.fmDescription.text = _model.desc;
    if ([_model.hot floatValue] > 10000) {
        self.comment.text = [NSString stringWithFormat:@"%.1f万",[_model.hot floatValue] / 10000];
    } else {
        self.comment.text = [NSString stringWithFormat:@"%@", _model.hot];
    }
    
    self.fmTime.text = _model.utime;
    
}


@end
