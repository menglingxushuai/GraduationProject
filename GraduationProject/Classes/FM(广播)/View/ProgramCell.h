//
//  ProgramCell.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/5/2.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMProgrameModel;
@interface ProgramCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *listen;
@property (weak, nonatomic) IBOutlet UILabel *praise;
@property (weak, nonatomic) IBOutlet UILabel *say;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) FMProgrameModel *model;
@end
