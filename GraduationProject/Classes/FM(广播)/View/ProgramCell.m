//
//  ProgramCell.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "ProgramCell.h"
#import "FMProgrameModel.h"
@implementation ProgramCell

- (void)setModel:(FMProgrameModel *)model {
    _model = model;
    self.title.text = [NSString stringWithFormat:@"%ld期:%@", _model.orderNum, _model.audioName];
    self.listen.text = [NSString stringWithFormat:@"%ld", _model.listenNum];
    self.praise.text = [NSString stringWithFormat:@"%ld", _model.likedNum];
    self.say.text = [NSString stringWithFormat:@"%ld", _model.commentNum];
    self.time.text = _model.updateTime;
    
}

@end
