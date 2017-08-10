//
//  CommentCell.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "CommentCell.h"
#import "FMProgrameModel.h"

@implementation CommentCell

- (void)setModel:(FMProgrameModel *)model {
    
    _model = model;
    [_MyImg sd_setImageWithURL:[NSURL URLWithString:_model.userImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _MyName.text = _model.userName;
    _comment.text = _model.content;
    _time.text = _model.updateTime;
    
    if (self.commentDelegate) {
        
        CGFloat height = [ToolForHeight textHeightWithText:_model.content font:[UIFont systemFontOfSize:17] width:kWindowWidth - 66];
        [self.commentDelegate heighOfCell:height + 45];
    }
}

@end
