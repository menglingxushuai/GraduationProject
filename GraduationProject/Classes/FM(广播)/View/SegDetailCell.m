//
//  SegDetailCell.m
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import "SegDetailCell.h"
#import "FMProgrameModel.h"
#import "DetailTagView.h"
#import "SFTagButton.h"
@implementation SegDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _heightLine.constant = (kWindowWidth - 40) / 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bindModel:(FMProgrameModel *)model atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            _anchor.text = [model.host[0] objectForKey:@"name"];
            _where.text = @"毕业设计";
            _uploading.text = model.uploadUserName;
            _stadus.text = [NSString stringWithFormat:@"%@%@",model.status,model.updateDay];
            break;
        case 1:
            _tagView.arr = model.keyWords;
            CGFloat height = _tagView.sfTag.frame.origin.y + _tagView.sfTag.height + 10;
            [self.detaileDelegate heightOfCellKeywords:height];
            break;
        case 2:
            _intro.text = model.radioDesc;
            CGFloat height2 = [ToolForHeight textHeightWithText:model.radioDesc font:[UIFont systemFontOfSize:17] width:kWindowWidth - 20];
            [self.detaileDelegate heightOfCell:height2 + 51];
            break;
        case 3:
            
            
            [_image1 sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"占位图"]];
            break;
            
        default:
            break;
    }
}


@end
