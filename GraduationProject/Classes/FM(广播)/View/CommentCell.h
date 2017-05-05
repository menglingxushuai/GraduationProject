//
//  CommentCell.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommentCellDelegate <NSObject>

- (void)heighOfCell:(CGFloat)heigh;

@end

@class FMProgrameModel;
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MyImg;
@property (weak, nonatomic) IBOutlet UILabel *MyName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (strong, nonatomic) FMProgrameModel *model;
@property (nonatomic, weak) id<CommentCellDelegate>commentDelegate;
@end
