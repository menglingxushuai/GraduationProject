//
//  FmDetailCell.h
//  GraduationProject
//
//  Created by 孟玲旭 on 2017/4/28.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMDetailModel;
@interface FmDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *fmDescription;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *fmTime;
@property (strong, nonatomic) FMDetailModel *model;
@end
